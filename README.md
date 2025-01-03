# python-app-gatling
python_get_post_app_gatling


Here are the steps to build application:

1. Login into GCP for access with appropriate GCP project
   gcloud auth login
2. Configure docker to have access to region in which you will push images
   gcloud auth configure-docker europe-west3-docker.pkg.dev
3. Enable (if necessary) artifact registry
   gcloud services enable artifactregistry.googleapis.com
4. Set GCP project if needed
   gcloud config set project sb-izal-20250103-132315
5. Create repository for application before building it
   gcloud artifacts repositories create gatling-tests --repository-format=docker --location=europe-west3 --description="Docker repository for Gatling load test"
6. In the root repository dir application can be built
   docker build -t europe-west3-docker.pkg.dev/sb-izal-20250103-132315/gatling-tests/gatling:latest .
7. Push application
   docker push europe-west3-docker.pkg.dev/sb-izal-20250103-132315/gatling-tests/gatling:latest
8. Deploy terraform configuration for Cloud Run HA setup for application
   terraform init
   terraform plan
   terraform apply