resource "time_static" "time_update" {
}
resource "local_file" "file1" {
  filename = "/home/rkyasan44/tf/resource-dependency/timedetails.txt"
  content  = "time is ${time_static.time_update.day}"
}