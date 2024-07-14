resource "local_file" "chey" {
 filename = "/home/rkyasan44/tf/cheyram.txt"
 content = data.local_file.pet.content
 
}

data "local_file" "pet" {
    filename="/home/rkyasan44/tf/local/f1.txt"
}
