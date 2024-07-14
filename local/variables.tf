variable "filename1" {
     default = [
          "./1.txt",
          "./2.txt",
          "./3.txt"
     ]
}

variable "filename2" {
     default = [
          "./1.txt",
          "./2.txt",
          "./3.txt",
          "./4.txt",
          "./5.txt"
     ]
}

variable "filename3" {

     type = set(string)

          default = [
          "./1x.txt",
          "./2x.txt",
          "./3x.txt",
          "./4x.txt",
          "./5x.txt"
     ]
}

variable "name" {
     type = string
     default = "Mark"
  
}
variable "number" {
     type = bool
     default = true
  
}
variable "distance" {
     type = number
     default = 5
  
}
variable "jedi" {
     type = map
     default = {
     filename = "/root/first-jedi"
     content = "phanius"
     }
  
}

variable "gender" {
     type = list(string)
     default = ["Male", "Female"]
}
variable "hard_drive" {
     type = map
     default = {
          slow = "HHD"
          fast = "SSD"
     }
}
variable "users" {
     type = set(string)
     default = ["tom", "jerry", "pluto", "daffy", "donald", "jerry", "chip", "dale"]

  
}

  





