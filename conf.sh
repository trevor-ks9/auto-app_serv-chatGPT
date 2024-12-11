# Set variables
APP_NAME=$(jq -r ".APP_NAME" app_vars.json)
RESOURCE_GROUP=$(jq -r ".RESOURCE_GROUP" app_vars.json)
LOCATION=$(jq -r ".LOCATION" app_vars.json)
SUBSCRIPTION=$(jq -r ".SUBSCRIPTION" app_vars.json)
RUNTIME=$(jq -r ".RUNTIME" app_vars.json)
SKU=$(jq -r ".SKU" app_vars.json)
while true; do
  STATUS=$(az webapp show --name "$APP_NAME" --resource-group "$RESOURCE_GROUP" --query "state" -o tsv)
  if [ "$STATUS" == "Running" ]; then
    echo "Web app is running."
    # Configure the startup file for Gunicorn
    az webapp config set --startup-file "pip install -r requirements.txt && python3 -m gunicorn app:app" --name "$APP_NAME" --resource-group "$RESOURCE_GROUP"
    # curl -o /home/site/wwwroot/requirements.txt https://raw.githubusercontent.com/navba-MSFT/sample-app-aoai-chatGPT/6bf7b6ac513708b25e48289795289c8a5d387107/requirements.txt
    # Set app settings for deployment
    az webapp config appsettings set -g "$RESOURCE_GROUP" -n "$APP_NAME" --settings WEBSITE_WEBDEPLOY_USE_SCM=false

    # Set app settings using the env.json file
    az webapp config appsettings set -g "$RESOURCE_GROUP" -n "$APP_NAME" --settings "@env.json"
    break
  else
    echo "Waiting for web app to finish building..."
    sleep 2
  fi
done
