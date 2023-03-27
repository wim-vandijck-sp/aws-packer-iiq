packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1.2.1"
    }
  }
}
source "amazon-ebs" "iiq-ami" {
  ami_name      = "iiq-testbuild-ami"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami    = "ami-0fec2c2e2017f4e7b"
  ssh_username  = "admin"
  // profile       = "aws-profile-name"
  skip_region_validation = "true"
  tags = {
    Name = "iiq-ami"
  }
}
build {
  sources = ["source.amazon-ebs.iiq-ami"]

  provisioner "ansible" {
    playbook_file = "./playbook.yaml"
    user          = "admin"
  }

}