terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "ubuntu" {
  name = "ubuntu:22.04"
}

resource "docker_container" "web_vm" {
  name  = "ansible_vm"
  image = docker_image.ubuntu.name
  tty   = true

  provisioner "remote-exec" {
    inline = ["apt update", "apt install -y openssh-server sudo"]
  }

  ports {
    internal = 22
    external = 2222
  }
}
