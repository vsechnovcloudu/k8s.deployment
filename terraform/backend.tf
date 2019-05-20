terraform {
  backend "gcs" {
    bucket = "my-statefiles"
    prefix = "services/myapp"
  }
}
