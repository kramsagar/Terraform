resource "local_file" "whale" {
  filename   = "/home/rkyasan44/tf/resource-dependency/whale"
  content    = "whale"
  depends_on = [local_file.krill]
}

resource "local_file" "krill" {
  filename = "/home/rkyasan44/tf/resource-dependency/krill"
  content  = "krill2.0"
}