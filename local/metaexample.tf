resource "local_file" "files" {
    filename = var.filename1[count.index]
    content = "tf code 123 meta-args"
    count = 3
}