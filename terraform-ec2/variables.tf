variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "terrakey"
}

variable "ami_id" {
  description = "AMI ID for the instances"
  type        = string
}

variable "aws_region" {
  default = "eu-west-1"
}

output "instance_ids" {
  value = aws_instance.example.*.id
}

output "public_ips" {
  value = aws_instance.example.*.public_ip
}