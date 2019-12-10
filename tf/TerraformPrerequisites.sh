
#Use Azure Storage as Backend for Terraform State

PREFIX=cytf
RESOURCE_GROUP_NAME=$PREFIX"-rg"
LOCATION=westeurope
STORAGE_ACCOUNT_NAME=$PREFIX"storage"
CONTAINER_NAME=$PREFIX"state"
KEYVAULT=$PREFIX"keyvault"


# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION --tags Environment=Development

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query [0].value -o tsv)

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY

az keyvault create --name $KEYVAULT --resource-group $RESOURCE_GROUP_NAME --location $LOCATION

az keyvault secret set --vault-name $KEYVAULT --name terraform-backend-key --value ACCOUNT_KEY

export ARM_ACCESS_KEY=$(az keyvault secret show --name terraform-backend-key --vault-name $KEYVAULT --query value -o tsv)

terraform init -backend-config="storage_account_name=$STORAGE_ACCOUNT_NAME" -backend-config="container_name=$CONTAINER_NAME" -backend-config="access_key=$ARM_ACCESS_KEY" -backend-config="key=$PREFIX.tfstate"
