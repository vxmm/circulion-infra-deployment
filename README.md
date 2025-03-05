# About

This is a novel implementation of a Lambda function which transfers data between two S3 buckets for the second assignment. 

For details on the code repository for the main assignment, see my [other project](https://github.com/vxmm/circulion-code-deployment). 

## Infrastructure Overview

 ![cl-overview-assignment-final](https://github.com/user-attachments/assets/350a4f44-577f-4c24-8b46-8770a49be23f)

## Lambda + S3 

The .tfstate is managed in S3 in accordance with best practices - if needed, we can implement [DyanmoDB or S3 state locking](https://developer.hashicorp.com/terraform/language/backend/s3) in order to ensure no conflicts occur on when the state file is being modified by several developers at the same time. 

The basic functionality of the Lambda is shown in this diagram.

![B-assignment](https://github.com/user-attachments/assets/134e9a8a-4df5-44d2-84b9-dd4f0e599793)

## Terraform

The project structure is designed around modules which are centered around AWS services, allowing a clear view into how each AWS service and component is involved in the project. 

![B-assignment-project](https://github.com/user-attachments/assets/d778e21e-0b73-413d-8f4f-e7929681f721) 

### Multi-region templating

In preparing for multi-region deployments, I've opted to involve templating in the project thus:

* buckets are provisioned with a standard name + region 

* lambda custom policies are created and attached to lambda using a .tpl file in the /iam folder  

## GitHub Actions + OpenID 

In order to authorise changes in the infrastructure, I've configured my personal AWS account to work with GitHub's OIDC as a federated identity instead of storing AWS credentials directly.

![B-assignment-oidc drawio](https://github.com/user-attachments/assets/45d290da-9d55-48d3-9711-e50f39ef76a2)

See GitHub's [official documentation](https://docs.github.com/en/actions/security-for-github-actions/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services) and this [detailed AWS example guide](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#links) on how to implement these changes in your AWS account.

## Validation

As proof of concept, I've written some validation steps for the project, which check:

* the name of the S3 input bucket matches the hardcoded beginning value cl-recipe-bucket-v2

* the name of the S3 input bucket matches the expected cl-recipe-bucket-v2-${current_region}

* all the region variables configured in both ./variables.tf and ./iam/variables.tf match 
