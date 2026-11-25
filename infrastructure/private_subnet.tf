resource "aws_subnet" "private" {
  for_each = local.private_subnets

  cidr_block        = each.value.cidr
  vpc_id            = aws_vpc.main.id
  availability_zone = each.value.az

  tags = {
    Name = "${local.env}-${each.key}"
  }
}