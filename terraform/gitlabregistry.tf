resource "kubernetes_secret" "docker-registry" {
  metadata {
    name = "docker-registry"
  }

  data {
    ".dockercfg" = <<EOF
{
  "registry.gitlab.com": {
    "username": "${var.docker_username}",
    "password": "${var.SERVICE_ACCESS_TOKEN}",
    "email": "${var.docker_email}",
    "auth": "${base64encode(format("%s:%s", var.docker_username, var.SERVICE_ACCESS_TOKEN))}"
  }
}
EOF
  }

  type = "kubernetes.io/dockercfg"
}
