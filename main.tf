# ─────────────────────────────────────────────────────────────
# Data sources
# ─────────────────────────────────────────────────────────────

data "aws_availability_zones" "available" {
  state = "available"
}

# ─────────────────────────────────────────────────────────────
# VPC Alpha
# ─────────────────────────────────────────────────────────────

resource "aws_vpc" "alpha" {
  cidr_block           = var.vpc_alpha_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-alpha"
  }
}

resource "aws_subnet" "alpha_private" {
  count = 2

  vpc_id            = aws_vpc.alpha.id
  cidr_block        = cidrsubnet(aws_vpc.alpha.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "vpc-alpha-private-${data.aws_availability_zones.available.names[count.index]}"
  }
}

# ─────────────────────────────────────────────────────────────
# VPC Beta
# ─────────────────────────────────────────────────────────────

resource "aws_vpc" "beta" {
  cidr_block           = var.vpc_beta_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-beta"
  }
}

resource "aws_subnet" "beta_private" {
  count = 2

  vpc_id            = aws_vpc.beta.id
  cidr_block        = cidrsubnet(aws_vpc.beta.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "vpc-beta-private-${data.aws_availability_zones.available.names[count.index]}"
  }
}

# ─────────────────────────────────────────────────────────────
# Private Route 53 Hosted Zone
# ─────────────────────────────────────────────────────────────

resource "aws_route53_zone" "private" {
  name = var.hosted_zone_name

  vpc {
    vpc_id = aws_vpc.alpha.id
  }

  vpc {
    vpc_id = aws_vpc.beta.id
  }

  comment = "Private hosted zone associated with vpc-alpha and vpc-beta"

  tags = {
    Name = var.hosted_zone_name
  }
}

# ─────────────────────────────────────────────────────────────
# VPC Association Authorization for cross-account / cross-VPC
# ─────────────────────────────────────────────────────────────

# Authorize Alpha to associate with the private zone
resource "aws_route53_vpc_association_authorization" "alpha" {
  vpc_id  = aws_vpc.alpha.id
  zone_id = aws_route53_zone.private.id
}

# Authorize Beta to associate with the private zone
resource "aws_route53_vpc_association_authorization" "beta" {
  vpc_id  = aws_vpc.beta.id
  zone_id = aws_route53_zone.private.id
}

# ─────────────────────────────────────────────────────────────
# Route 53 Zone Associations
# ─────────────────────────────────────────────────────────────

resource "aws_route53_zone_association" "alpha" {
  zone_id = aws_route53_zone.private.id
  vpc_id  = aws_vpc.alpha.id

  depends_on = [aws_route53_vpc_association_authorization.alpha]
}

resource "aws_route53_zone_association" "beta" {
  zone_id = aws_route53_zone.private.id
  vpc_id  = aws_vpc.beta.id

  depends_on = [aws_route53_vpc_association_authorization.beta]
}
