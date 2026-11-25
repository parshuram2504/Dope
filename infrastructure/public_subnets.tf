resource "aws_subnet" "public" {
  count = length(local.public_subnet_cidrs)
  cidr_block = local.public_subnet_cidrs[count.index]
  vpc_id     = aws_vpc.main.id
  availability_zone = local.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.env}-public-subnet-${count.index + 1}"
  }
}