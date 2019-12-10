Follow one of the quickstarts here to create an Azure Container Registry

Enable admin user to make our lives easier for development. After the resource is created grab the password from the settings under Access Keys.

Log into Azure Container Registry to upload images 
az acr login --name=bbmicroservicesacr

Build image and upload to Azure Container Registry
az acr build --registry bbmicroservicesacr --image bbmicroservicescrud:1 .

To verify with local docker:
az acr credential show -n acrcesar9132

docker login https://bbmicroservicesacr.azurecr.io -u bbmicroservicesacr -p <put in password>

docker run -d -p 8080:80 bbmicroservicesacr.azurecr.io/bbmicroservicescrud:1

