variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "Example_Instance"
}

variable "ami" {
  description = "ami"
  type        = string
  default     = "ami-006dcf34c09e50022"
}

variable "instance_type" {
  description = "the type to be used"
  type        = string
  default     = "t2.micro"
}
