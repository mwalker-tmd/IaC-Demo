resource "aws_subnet" "private_zone_1" {
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = "10.0.0.0/19"
  availability_zone = var.aws_zone_1

  tags = {
    Name                                                   = "${var.env}-${var.project_name}-private-${var.aws_zone_1}"
    "kubernetes.io/role/internal-elb"                      = "1"
    "kubernetes.io/cluster/${var.env}-${var.project_name}" = "owned"
  }
}

resource "aws_subnet" "private_zone_2" {
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = "10.0.32.0/19"
  availability_zone = var.aws_zone_2

  tags = {
    Name                                                   = "${var.env}-${var.project_name}-private-${var.aws_zone_2}"
    "kubernetes.io/role/internal-elb"                      = "1"
    "kubernetes.io/cluster/${var.env}-${var.project_name}" = "owned"
  }
}

resource "aws_subnet" "public_zone_1" {
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = "10.0.64.0/19"
  availability_zone = var.aws_zone_1

  tags = {
    Name                                                   = "${var.env}-${var.project_name}-public-${var.aws_zone_1}"
    "kubernetes.io/role/elb"                               = "1"
    "kubernetes.io/cluster/${var.env}-${var.project_name}" = "owned"
  }
}

resource "aws_subnet" "public_zone_2" {
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = "10.0.96.0/19"
  availability_zone = var.aws_zone_2

  tags = {
    Name                                                   = "${var.env}-${var.project_name}-public-${var.aws_zone_2}"
    "kubernetes.io/role/elb"                               = "1"
    "kubernetes.io/cluster/${var.env}-${var.project_name}" = "owned"
  }
}