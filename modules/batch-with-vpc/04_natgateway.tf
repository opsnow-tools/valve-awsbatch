# eip & nat-gateway

resource "aws_eip" "private_A" {
  vpc        = true
  depends_on = [aws_route_table.public]
  tags = merge(
    {
      "Name" = "${local.az_name_A}-PRIVATE"
    }
  )
}

resource "aws_eip" "private_B" {
  vpc        = true
  depends_on = [aws_route_table.public]
  tags = merge(
    {
      "Name" = "${local.az_name_B}-PRIVATE"
    }
  )
}

resource "aws_eip" "private_C" {
  vpc        = true
  depends_on = [aws_route_table.public]
  tags = merge(
    {
      "Name" = "${local.az_name_C}-PRIVATE"
    }
  )
}

resource "aws_nat_gateway" "private_A" {
  allocation_id = aws_eip.private_A.id
  subnet_id     = aws_subnet.public_A.id
  tags = merge(
    {
      "Name" = "${local.az_name_A}-PRIVATE"
    }
  )
}

resource "aws_nat_gateway" "private_B" {
  allocation_id = aws_eip.private_B.id
  subnet_id     = aws_subnet.public_B.id
  tags = merge(
    {
      "Name" = "${local.az_name_B}-PRIVATE"
    }
  )
}

resource "aws_nat_gateway" "private_C" {
  allocation_id = aws_eip.private_C.id
  subnet_id     = aws_subnet.public_C.id
  tags = merge(
    {
      "Name" = "${local.az_name_C}-PRIVATE"
    },
  )
}
