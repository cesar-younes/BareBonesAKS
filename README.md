# BareBonesAKS
Infrastructure as Code used for the other BareBones repos. This project uses Terraform to privision an Azure Kubernetes Service(AKS) cluster and an Azure Container Repository

As a prerequisite to Terraform there's a script that sets up an Azure Resource Group with an Azure Storage account. This resource group will generally be used for resources that I don't expect to be updated or changed frequently.

The Azure Storage will also get set up as the state backend for Terraform