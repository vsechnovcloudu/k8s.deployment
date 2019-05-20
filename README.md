Service deployment to Kubernetes
================================

Example of service deployment using Terraform, Kubernetes and GitLab CI.

# Prerequisities / assumptions

- Project hosted on GitLab public service. Branches `dev, test, master` are used as a switch between target environments, where `master` is considered as *production*. Merge requests between branches are staging process with necessary approvals via [CODEOWNERS](https://docs.gitlab.com/ee/user/project/code_owners.html).
- Kubernetes cluster running in Google Cloud Platform - each cluster with names (`my-cluster-*dev*`, `my-cluster-*test*` etc.) represents one environment.
- During pipeline run, branch switch is realized by $CI_COMMIT_REF_NAME variable - which contains branch (or tag) name. This is used for selecting right Kubernetes cluster, to select Terraform workspace and to select correct variable file for Terraform during deployment phase.
- Each service has it's own repository similar to this one, containing application code, tests and also Terraform code describing the service itself (normally imported as Terraform module from central repository).

# Required variables set on GitLab CI pipeline parameter store

When registering variable used by Terraform, [you have to give it a prefix `TF_VAR_`](https://learn.hashicorp.com/terraform/getting-started/variables.html), so Terraform can read it during its run. For example: `SERVICE_ACCESS_TOKEN` in Terraform has name `TF_VAR_SERVICE_ACCESS_TOKEN` in GitLab.

- Google Cloud JSON token uploaded as a file, used for general platform authorization. Used by Terraform to access the bucket with statefile. You have to create Service Account in GCP and download the token in advance.
- GitLab personal access token of technical user to (read only) access GitLab image registry. Used by Terraform / Kubernetes provider, replacing need for username and password.
