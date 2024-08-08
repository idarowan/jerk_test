packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
    ansible = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  region          = "eu-west-1"
  source_ami      = "ami-0905a3c97561e0b69"
  instance_type   = "t2.micro"
  ssh_username    = "ubuntu"
  ami_name        = "custom-ubuntu-ami-for-daro"
  ami_description = "Ubuntu with MongoDB Shell and MySQL preinstalled"
  tags = {
    Name = "custom-ubuntu-ami-${timestamp()}"
  }
}

build {
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "ansible" {
    playbook_file = "./ansible/playbook.yml"
    extra_arguments = [
      "--extra-vars", "ansible_local_temp=${env.ANSIBLE_LOCAL_TEMP} ansible_remote_temp=${env.ANSIBLE_REMOTE_TEMP}"
    ]
  }
}
