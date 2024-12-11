# IaC-Demo
Kubernetes Cluster Config Demo using Terraform

## Overview
This project is based on the [AWS EKS Kubernetes Tutorial](https://www.youtube.com/playlist?list=PLiMWaCMwGJXnKY6XmeifEpjIfkWRo9v2l) 
by Anton Putra. The project is a demonstration of how to create an EKS cluster using Terraform and deploy a simple
application to the cluster. My goals are:
- Learn how to use Terraform to:
  - Create an EKS cluster
  - Manage Kubernetes resources
  - Manage AWS resources
- Learn how to deploy an application to the cluster
- Learn how to use Helm to manage Kubernetes applications
- Turn the tutorial into a production-ready project by applying best practices for managing infrastructure as code

### First Attempt
My first attempt was not done using Anton's tutorial. It was based on several other tutorials I found online.
I learned quite a lot along the way, as one does when working through the issues and challenges which arise during the 
development process. I was able to create the necessary prerequisites (networking, security, and privileges) and partially 
create an EKS cluster. The worker nodes were unable to join the cluster though. It was while researching how to correct
this issue that I found Anton's tutorial. After verifying the final version of the tutorial results in successfully creating
an EKS cluster, I decided to start over and follow his tutorial to completion, applying the best practices I have learned
along the way (using variables, static code analysis, build and tear down validations, etc.).  

I have documented the final issue in [Issue #6](https://github.com/mwalker-tmd/IaC-Demo/issues/6).
The last commit of the code for this first attempt is [Commit e91e054](https://github.com/mwalker-tmd/IaC-Demo/commit/e91e0544bb2cba39a617c7cad0d7130f906138f5).

### Second Attempt
(placeholder)

## Getting Started
### Prerequisites
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- [Checkov](https://www.checkov.io/1.Welcome/Quick%20Start.html) (static code analysis tool for Terraform)


### Process
As before, I will be following this process:
1. Implement the code for the current step of the tutorial
2. Use Checkov to validate the code (`checkov -d .`)
3. Use Terraform to apply the code:
    - `terraform plan {plan_output_file}`
    - `terraform apply {plan_output_file}`
4. Validate the results
5. Use Terraform to destroy the resources:
    - `terraform destroy` (to clean up after the tutorial step is complete)
6. Create a tag and release
