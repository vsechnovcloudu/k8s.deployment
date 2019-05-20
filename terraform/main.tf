resource "kubernetes_service" "app" {
  metadata {
    name = "my-application"
  }

  spec {
    selector {
      app = "${kubernetes_pod.app.metadata.0.labels.app}"
    }

    session_affinity = "ClientIP"

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_pod" "app" {
  metadata {
    name = "my-app"

    labels {
      app = "MyApplication"
    }
  }

  spec {
    image_pull_secrets {
      name = "docker-registry"
    }

    container {
      image = "${var.image}:${var.tag}"
      name  = "my-app"
    }
  }
}
