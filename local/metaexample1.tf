resource "local_file" "pet123" {
    filename = var.filename2[count.index]
    content="meta args dynamic content"
    count  = length(var.filename2)
    
}
