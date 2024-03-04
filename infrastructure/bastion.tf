resource "aws_instance" "terraform-bastion" {
  ami                         = lookup(var.AMIS, var.AWS_REGION)
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = aws_key_pair.projectkey.key_name
  subnet_id                   = module.vpc.public_subnets[0]
  count                       = var.instance_count
  vpc_security_group_ids      = [aws_security_group.terraform-bastion-sg.id]

  tags = {
    Name    = "Terraform-bastion"
    PROJECT = "Terraform"
  }

  provisioner "file" {
    content     = templatefile("db_deploy.tmpl", { rds-endpoint = aws_db_instance.terraform-rds.address, dbuser = var.dbuser, dbpass = var.dbpass })
    destination = "/tmp/terraform-dbdeploy.sh"

  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/terraform-dbdeploy.sh",
      "sudo /tmp/terraform-dbdeploy.sh"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.PRIV_KEY_PATH)
    host        = self.public_ip
  }
  depends_on = [aws_db_instance.terraform-rds]
}