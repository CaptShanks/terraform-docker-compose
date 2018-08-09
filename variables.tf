variable "region" {
  description = "The AWS Region to use "
  default     = "us-west-2"
}

variable "ami" {
  description = "The aws AMI is to use"
  default     = "ami-a3ebbfdb"
}

variable "instance_type" {
  description = "The AWS instance type to use"
  default     = "t2.2xlarge"
  
}
