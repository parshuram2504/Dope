resource "aws_subnet" "private_subnet" {
  cidr_block = "10.0.3.0/24"
  vpc_id     = aws_vpc.main.id
  availability_zone = "ap-south-1a"

  tags = {
    Name = "private-subnet"
  }
}

resource "aws_subnet" "private_subnet_2" {
  cidr_block = "10.0.4.0/24"
  vpc_id     = aws_vpc.main.id
  availability_zone = "ap-south-1b"

  tags = {
    Name = "private-subnet-2"
  }
}