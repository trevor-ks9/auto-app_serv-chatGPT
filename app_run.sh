# Run the Bicep deployment
./bicep_extract.sh 
# Deploy the app and configure it in parallel
./app_deploy.sh & 
./conf.sh & 
# Wait for background tasks to complete

