Service description
===================

## main.tf

Contains general service definition with pod description (could be deployment instead). This file receives two variables from the pipeline - `image` and `tag`. Could be more generalised to also receive `service_name`, thus whole service would become Terraform module, used by multiple applications.

## gitlabregistry.tf

This file creates access for Kubernetes cluster to image registry on GitLab side. You can login to image registry using username and password - however for better security, we assume an existence of technical user account in GitLab with personal access token - and this token is passed as `SERVICE_ACCESS_TOKEN` variable from variable store on GitLab side.

## provider.tf

As we login to GKE during a run of the pipeline, there is no need for any static credentials in this file.

## data.tf

This is a list of required variables. Variables `tag` and `image` are provided during Terraform apply via command line. Variable `SERVICE_ACCESS_TOKEN` is provided by GitLab variable store. We use this token for authentication and authorization instead of username/password.

## /tfvars

During deployment, file containing variables is also called, so for each environment we have to have one file. At the moment, files are empty, waiting for better use :).
