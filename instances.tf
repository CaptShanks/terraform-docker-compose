resource "aws_instance" "master" {
  ami = "${var.ami}"

  instance_type   = "${var.instance_type}"
  security_groups = ["${aws_security_group.swarm.name}"]
  key_name        = "${aws_key_pair.deployer.key_name}"

  connection {
    user        = "ubuntu"
    private_key = "${file("/home/shashankt/.ssh/id_rsa")}"
  }

  provisioner "file" {
    source      = "./script1.sh"
    destination = "/home/ubuntu/script1.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install apt-transport-https ca-certificates",
      "sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D",
      "sudo sh -c 'echo \"deb https://apt.dockerproject.org/repo ubuntu-trusty main\" > /etc/apt/sources.list.d/docker.list'",
      "sudo apt-get update",
      "sudo apt-get install -y docker-engine=1.12.0-0~trusty",
      "sudo curl -L https://github.com/docker/compose/releases/download/1.10.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose",
      "sudo chmod +x /usr/local/bin/docker-compose",
      "sudo git clone https://github.com/mStakx/observability-boilerplate1.git",
      "cd  observability-boilerplate1",
      "sudo echo -e '\n'|ssh-keygen -t rsa -N ''",
      "sudo cp ~/.ssh/id_rsa.pub ~/observability-boilerplate1/deploy/django/",
      "sudo cp ~/script1.sh ~/observability-boilerplate1/script1.sh",
      "sudo sysctl -w vm.max_map_count=262144",
      "sudo nohup sh setup.sh &",
      "sudo sh script1.sh",
      #"PID=$!",
      #"wait $PID",
      #"echo finished setup.sh",
      #"sudo sh es_index.sh",
    ]
  }

  tags = {
    Name = "test-observevability"
  }
}
