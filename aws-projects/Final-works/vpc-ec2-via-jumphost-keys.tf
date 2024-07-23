# Define a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"  # Replace with your desired CIDR block

  tags = {
    Name = "MainVPC"
  }
}

#4 : create IGW
resource "aws_internet_gateway" "myIgw"{
    vpc_id = aws_vpc.my_vpc.id
     tags = {
      Name="IG-${aws_vpc.my_vpc.id}"
    }

}

resource "aws_route_table" "PublicRT"{
    vpc_id = aws_vpc.my_vpc.id
    route {
        cidr_block = "0.0.0.0/0"  #it means every ip should be connect to internet.
        gateway_id = aws_internet_gateway.myIgw.id
    }
     tags = {
      Name="RTTable-${aws_vpc.my_vpc.id}"
    }

}

resource "aws_subnet" "example_subnet" {
  vpc_id            = aws_vpc.my_vpc.id  # Ensure it belongs to the same VPC
  cidr_block        = "10.0.1.0/24"    # Replace with your subnet CIDR block
  availability_zone = "us-east-1a"     # Replace with your desired AZ

  tags = {
    Name = "Ram_ExampleSubnet"
  }
}

# Define private subnet (for your EC2 instances)
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Ram-PrivateSubnet"
  }
}

resource "aws_route_table_association" "example_subnet_association" {
  subnet_id      = aws_subnet.example_subnet.id
  route_table_id = aws_route_table.PublicRT.id
}


# Create security group for bastion host
resource "aws_security_group" "bastion_sg" {
  name        = "BastionSecurityGroup"
  description = "Allow SSH access to bastion host"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Ram_BastionSG"
  }
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  filename = "${path.module}/ramsagar-private_key.pem"
  content  = tls_private_key.ssh_key.private_key_pem
}

resource "aws_key_pair" "name" {
  key_name   = "terraform-ramgen-123-private-key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

# Create bastion host in public subnet
resource "aws_instance" "bastion_host" {
  ami                    = var.ami # Replace with your desired AMI ID
  instance_type          = var.instance_type              # Replace with your desired instance type
  subnet_id              = aws_subnet.example_subnet.id
  associate_public_ip_address = true  # Ensure it has a public IP for SSH access
  security_groups        = [aws_security_group.bastion_sg.id]
  key_name               = "terraform-ramgen-123-private-key"  # Use SSH key name

  tags = {
    Name = "Ram_verynew_BastionHost"
  }
}


# Define a security group
resource "aws_security_group" "instance_sg" {
  name        = "My_instance_sg"
  description = "Allow inbound SSH and HTTP traffic"

  vpc_id = aws_vpc.my_vpc.id  # Associate with the VPC defined above

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    #cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from anywhere
    security_groups = [ aws_security_group.bastion_sg.id ]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP access from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Ram_PrivateSG"
  }
}


# Define an private subnet EC2 instance
resource "aws_instance" "example" {
  ami           = var.ami  # Replace with your desired AMI ID
  instance_type = var.instance_type               # Replace with your desired instance type
  subnet_id = aws_subnet.example_subnet.id
  #associate_public_ip_address = true  # Assign a public IP address
  vpc_security_group_ids = [aws_security_group.instance_sg.id]  # Attach the security group
  key_name               = "terraform-ramgen-123-private-key"  # Use SSH key name

  tags = {
    Name = "My_new_Ram_Instance"
  }
}

resource "null_resource" "download_private_file_key" {
  connection {
    type        = "ssh"
    host        = aws_instance.bastion_host.public_ip
    user        = "ec2-user"  # Replace with appropriate user for your AMI
    private_key = tls_private_key.ssh_key.private_key_pem
  }

  provisioner "file" {
    source      = "${path.module}/ramsagar-private_key.pem"
    destination = "/tmp/terraform_private_key.pub"
  }
}