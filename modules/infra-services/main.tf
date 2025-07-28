resource "null_resource" "install_services" {
  depends_on = [var.ec2_instance]

  triggers = {
    always_run = timestamp()
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = var.ec2_public_ip
  }

  provisioner "remote-exec" {
    inline = [


      # System prep
      "sudo apt update && sudo apt upgrade -y",
      "sudo apt install -y apt-transport-https ca-certificates curl software-properties-common gnupg2",

      # Docker repo & install
      "if [ ! -f /usr/share/keyrings/docker-archive-keyring.gpg ]; then curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg; fi",
      "echo \"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
      "sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin",

      # Docker group setup
      "sudo usermod -aG docker ubuntu",
      "sudo systemctl enable docker && sudo systemctl start docker",

      # Terraform install
    "sudo snap install terraform --classic",
      "terraform -version",

      # kubectl install
      "curl -LO \"https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl\"",
      "sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl",
      "kubectl version --client"
    ]
  }
}
