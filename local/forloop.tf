resource "local_file" "forFile" {
    filename = each.value
    for_each = var.filename3
    content = "for loop content"
}