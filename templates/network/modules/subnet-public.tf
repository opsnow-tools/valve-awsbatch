# subnet-public.tf

## local variable
locals {
  public_a_cidr = "10.253.1.0/24"
  public_a_az   = "ap-northeast-2a"
  public_b_cidr = "10.253.2.0/24"
  public_b_az   = "ap-northeast-2a"
  public_c_cidr = "10.253.3.0/24"
  public_c_az   = "ap-northeast-2c"
}

## cluster subnet public
resource "aws_subnet" "public_A" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = local.public_a_cidr
  availability_zone = local.public_a_az
  tags = merge(
    {
      "Name" = "${local.az_name_A}-PUBLIC"
    }
  )
}

resource "aws_subnet" "public_B" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = local.public_b_cidr
  availability_zone = local.public_b_az
  tags = merge(
    {
      "Name" = "${local.az_name_B}-PUBLIC"
    
  )
}

resource "aws_subnet" "public_C" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = local.public_c_cidr
  availability_zone = local.public_c_az
  tags = merge(
    {
      "Name" = "${local.az_name_C}-PUBLIC"
    }
  )
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      "Name" = local.upper_name
    }
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(
    {
      "Name" = "${local.upper_name}-PUBLIC"
    }
  )
}

resource "aws_route_table_association" "public_A" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_A.id
}

resource "aws_route_table_association" "public_B" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_B.id
}

resource "aws_route_table_association" "public_C" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_C.id
}
