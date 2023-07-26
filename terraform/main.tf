provider "aws"{
  region = "us-east-1"
}


resource "aws_vpc" "myapp-vpc"{
  cidr_block = var.cidr_blocks[0].cidr_block
  tags = {
    Name: "${var.cidr_blocks[0].name}-vpc",
  }
}

resource "aws_subnet" "myapp-subnet-1" {
  vpc_id = aws_vpc.myapp-vpc.id
  cidr_block = var.cidr_blocks[1].cidr_block
  availability_zone = "us-east-1a"
  tags = {
    Name: "${var.cidr_blocks[1].name}-subnet"
  }
}

resource "aws_internet_gateway" "myapp-gateway" {
  vpc_id = aws_vpc.myapp-vpc.id
  tags = {
    Name: "${var.env_prefix}-igw"
  }
}
resource "aws_route_table" "myapp-route-table" {

  vpc_id         = aws_vpc.myapp-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myapp-gateway.id
  }
  tags = {
    Name: "${var.env_prefix}-rtb"
  }
}

resource "aws_route_table_association" "a-rtb-subnet" {
  subnet_id = aws_subnet.myapp-subnet-1.id
  route_table_id = aws_route_table.myapp-route-table.id
}

resource "aws_security_group" "myapp-sg" {
  name = "myapp-sg"
  vpc_id = aws_vpc.myapp-vpc.id
  ingress {
    //to allow ssh connection on EC2 instance
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
    cidr_blocks = var.my_ip
  }
  ingress {
    //to be able to connect to the ngnix container
    from_port = 8080
    protocol  = "tcp"
    to_port   = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    //to allow the instance to connect to yum repo to to install docker
    from_port = 443
    protocol  = "tcp"
    to_port   = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_instance" "myapp-server" {
  availability_zone = "us-east-1a"
  ami = "ami-05548f9cecf47b442"
  instance_type = var.instance_type
  subnet_id = aws_subnet.myapp-subnet-1.id
  vpc_security_group_ids = [aws_security_group.myapp-sg.id]
  associate_public_ip_address = true
  key_name = "new1" // this key was generated before and I generated a .ppk to ssh from putty
  user_data = file("entry-script.sh")
  tags = {
    Name = "${var.env_prefix}-server"
  }
}


