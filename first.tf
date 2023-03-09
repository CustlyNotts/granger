# Define AWS provider
provider "aws" {
  region = "us-east-1"
}

# Create EC2 instance
resource "aws_instance" "example" {
  ami                         = var.ami
  instance_type               = var.instance_type
  iam_instance_profile        = aws_iam_instance_profile.example.name
  associate_public_ip_address = false
  tags = {
    Name = var.instance_name
  }
}



# Create S3 bucket
resource "aws_s3_bucket" "example" {
  bucket = "example-bucket09084676355243625452453"
  tags = {
    Name = "example-bucket"
  }
}

resource "aws_s3_bucket_acl" "example_bucket_acl" {
  bucket = aws_s3_bucket.example.id
  acl    = "private"
}

# Grant read/write access to S3 bucket
resource "aws_iam_role" "example" {
  name = "example-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "example" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.example.name
}

# Attach IAM role to EC2 instance
resource "aws_iam_instance_profile" "example" {
  name = "example-profile"
  role = aws_iam_role.example.name
}

output "instance_ip_addr" {
  value       = aws_instance.example.private_ip
  description = "The private IP address of the ec2 instance."
}
