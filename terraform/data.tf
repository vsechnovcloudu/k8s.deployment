variable "tag" {
  description = "tag name from last successful build"
}

variable "image" {
  description = "name of the image from CONTAINER_IMAGE"
}

variable "SERVICE_ACCESS_TOKEN" {
  description = "personal access token - technical user with read only repo scope"
}

variable "docker_email" {
  default     = ""
  description = "your email"
}

variable "docker_username" {
  default     = ""
  description = "your username"
}
