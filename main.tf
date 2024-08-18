//vpc,subnet,igw,routtable,aws route associate,security group,ec2
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.10.0.0/16"
  
}
resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.10.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "my_subnet"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "igw"
  }
}
resource "aws_route_table" "example" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "my_route"
  }
}
resource "aws_route_table_association" "demo_associate_route" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.example.id
}
resource "aws_security_group" "example" {
  name        = "example-security-group"
  description = "Security group for EC2 instance"
  vpc_id = aws_vpc.my_vpc.id  # Replace with your VPC ID

  # Inbound Rules
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow from anywhere (use your specific IP or range for better security)
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound Rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "example-security-group"
  }
}
resource "aws_instance" "web" {
  ami           = "ami-0ae8f15ae66fe8cda"
  instance_type = "t2.micro"
  key_name = "jenkins"
  subnet_id = aws_subnet.my_subnet.id
  vpc_security_group_ids = [ aws_security_group.example.id]
  tags = {
    Name = "my-server"
  }
}