# (Preview) Sample Chat App with AOAI

# Setup Instructions

These instructions are built on top of the Microsoft GitHub repo for the [sample-app-aoai-chatGPT](https://github.com/microsoft/sample-app-aoai-chatGPT). Please note that this is not yet production-ready and will require some minor updates and patches. The updated application automates the deployment of an App Service along with an Azure OpenAI app. By deploying this app, you will also be deploying Azure AI; however, a few configuration steps within Microsoft Azure are needed for both the App Service and Azure OpenAI to work properly. For additional configuration details on the App Service, please refer to the documentation.

## Prerequisites

Before getting started, ensure you have the following:

- Add `RESOURCE_GROUP` in `bicep_extract.sh`.
- Update `aiServicesName` in `bicep_extract.bicep`.
- Update the parameter values in `app_vars.json` (e.g., `APP_NAME`, `RESOURCE_GROUP`, `LOCATION`, `SUBSCRIPTION`, `RUNTIME`, `SKU`).
- Once that's done, run `app_run.sh`.
