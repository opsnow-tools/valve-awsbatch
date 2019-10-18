# private-subnet.tf

/*
  private_a_cidr : az A / private subnet cidr
  private_a_az : name of az A
  private_c_cidr : az C / public subnet cidr
  pvirate_c_az : name of az C
*/

locals {
  private_a_cidr = "10.253.4.0/24"
  private_a_az   = "ap-northeast-2a"
  private_b_cidr = "10.253.5.0/24"
  private_b_az   = "ap-northeast-2a"
  private_c_cidr = "10.253.6.0/24"
  private_c_az   = "ap-northeast-2c"
}

# cluster subnet private
resource "aws_subnet" "private_A" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = local.private_a_cidr
  availability_zone = local.private_a_az
  tags = merge(
    {
      "Name" = "${local.az_name_A}-PRIVATE"
    }
  )
}

resource "aws_subnet" "private_B" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = local.private_b_cidr
  availability_zone = local.private_b_az
  tags = merge(
    {
      "Name" = "${local.az_name_B}-PRIVATE"
    }
  )
}

resource "aws_subnet" "private_C" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = local.private_c_cidr
  availability_zone = local.private_c_az
  tags = merge(
    {
      "Name" = "${local.az_name_C}-PRIVATE"
    }
  )
}

resource "aws_route_table" "private_A" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.private_A.id
  }

  tags = merge(
    {
      "Name" = "${local.az_name_A}-PRIVATE"
    }
  )
}

resource "aws_route_table" "private_B" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.private_B.id
  }

  tags = merge(
    {
      "Name" = "${local.az_name_B}-PRIVATE"
    }
  )
}

resource "aws_route_table" "private_C" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.private_C.id
  }

  tags = merge(
    {
      "Name" = "${local.az_name_C}-PRIVATE"
    }
  )
}

resource "aws_route_table_association" "private_A" {
  route_table_id = aws_route_table.private_A.id
  subnet_id      = aws_subnet.private_A.id
}

resource "aws_route_table_association" "private_B" {
  route_table_id = aws_route_table.private_B.id
  subnet_id      = aws_subnet.private_B.id
}

resource "aws_route_table_association" "private_C" {
  route_table_id = aws_route_table.private_C.id
  subnet_id      = aws_subnet.private_C.id
}
