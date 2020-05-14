terraform {
  backend "local" {
    path = "/tmp/terraform/workspace/terraform.tfstate"
  }

}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "backend" {
  ami                    = "ami-039a49e70ea773ffc"
  instance_type          = "t2.micro"
  key_name               = "${var.nvkey}"
  vpc_security_group_ids = ["${var.sg1}"]

}


resource "null_resource" "remote-exec-1" {
    connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = "${file(var.pvt_key)}"
    host        = "${aws_instance.backend.public_ip}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install python sshpass -y",
    ]
  }
}

resource "null_resource" "ansible-main" {
provisioner "local-exec" {
  command = <<EOT
        sleep 100;
        > jenkins-ci.ini;
        echo "[jenkins-ci]"| tee -a jenkins-ci.ini;
        export ANSIBLE_HOST_KEY_CHECKING=False;
        echo "${aws_instance.backend.public_ip}" | tee -a jenkins-ci.ini;
        ansible-playbook  --key=${var.pvt_key} -i jenkins-ci.ini ./ansible-code/05-Tomcat/playbook.yaml -u ubuntu -v
    EOT
}
}

