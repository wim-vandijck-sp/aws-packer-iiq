packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1.2.1"
    }
    ansible = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

source "amazon-ebs" "iiq-ami" {
  ami_name              = "iiq-testbuild-ami"
  ami_description       = "Test Build for Automated IIQ Image"
  force_deregister      = "true"
  force_delete_snapshot = "true"
  instance_type         = "t2.medium"
  region                = "us-east-1"
  source_ami            = "ami-0fec2c2e2017f4e7b"
  ssh_username          = "admin"
  // profile       = "aws-profile-name"
  skip_region_validation = "true"
  tags = {
    Name = "iiq-ami"
  }
}
build {
  sources = ["source.amazon-ebs.iiq-ami"]

  provisioner "ansible" {
    playbook_file = "ansible/playbook.yml"
    galaxy_file   = "ansible/roles/requirements.yml"
    user          = "admin"
    extra_arguments = [
      "--vault-password-file", "./vaultpasswordfile",
      "--ssh-extra-args", "-o IdentitiesOnly=yes -o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedAlgorithms=+ssh-rsa",
      "--extra-vars", "java_version=11 java_default_version=11"
    ]
  }

}