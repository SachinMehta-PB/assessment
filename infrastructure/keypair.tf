resource "aws_key_pair" "projectkey" {
  key_name   = "projectkey"
  public_key = file(var.PUB_KEY_PATH)
}