data "aws_availability_zones" "available" {}


resource "aws_vpc" "octabyte" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name      = "octabyte-vpc"
    terraform = "true"
  }
}

resource "aws_internet_gateway" "octabyte" {
  vpc_id = aws_vpc.octabyte.id

  tags = {
    Name      = "octabyte-igw"
    terraform = "true"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.octabyte.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.octabyte.id
  }

  tags = {
    Name      = "octabyte-public-rt"
    terraform = "true"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.octabyte.id
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name      = "public-subnet-${count.index + 1}"
    terraform = "true"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.octabyte.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name      = "private-subnet-${count.index + 1}"
    terraform = "true"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name      = "octabyte-nat-eip"
    terraform = "true"
  }
}
resource "aws_nat_gateway" "octabyte" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name      = "octabyte-nat-gw"
    terraform = "true"
  }

  depends_on = [aws_internet_gateway.octabyte]
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.octabyte.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.octabyte.id
  }

  tags = {
    Name      = "octabyte-private-rt"
    terraform = "true"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}