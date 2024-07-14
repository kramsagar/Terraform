//https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key

resource "tls_private_key" "pvtkey" {
    algorithm = "RSA"
    rsa_bits = "4096"
}

resource "local_file" "key_details" {
  filename="/home/rkyasan44/tf/local/key.txt"
  content="${tls_private_key.pvtkey.private_key_pem}"
}