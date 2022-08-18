# GCP - Cloud Foundation

## Description

This project demonstrates how to create a foundation for your GCP project so that you can start building your systems following the best practices.

Resources created:
- VPC
- Firewall rules
- Subnets
- NAT
- Docker repository


## Deploy

1. Create a new project and select it.

2. Open Cloud Shell and ensure the var below is set, otherwise set it with `gcloud config set project` command
```
echo $GOOGLE_CLOUD_PROJECT
```

3. Create a bucket to store your project's Terraform state
```
gsutil mb gs://$GOOGLE_CLOUD_PROJECT-tf-state
```

4. Enable the necessary APIs
```
gcloud services enable cloudbuild.googleapis.com \
compute.googleapis.com \
container.googleapis.com \
cloudresourcemanager.googleapis.com \
containersecurity.googleapis.com \
datamigration.googleapis.com \
servicenetworking.googleapis.com \
artifactregistry.googleapis.com \
sqladmin.googleapis.com \
vpcaccess.googleapis.com
```

5. Give permissions to Cloud Build for creating the resources
```
PROJECT_NUMBER=$(gcloud projects describe $GOOGLE_CLOUD_PROJECT --format='value(projectNumber)')
gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT --member=serviceAccount:$PROJECT_NUMBER@cloudbuild.gserviceaccount.com --role=roles/editor
gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT --member=serviceAccount:$PROJECT_NUMBER@cloudbuild.gserviceaccount.com --role=roles/compute.networkAdmin
gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT --member=serviceAccount:$PROJECT_NUMBER@cloudbuild.gserviceaccount.com --role=roles/iam.securityAdmin
```

6. Clone this repo into the Cloud Shell VM
```
git clone https://github.com/sylvioneto/gcp-cloud-foundation
```

7. Execute Terraform using Cloud Build
```
gcloud builds submit ./terraform --config cloudbuild.yaml
```

8. (Optional) Customize [terraform.tfvars](./terraform/terraform.tfvars) according to your needs.

## Destroy
1. Execute Terraform using Cloud Build
```
gcloud builds submit ./terraform --config cloudbuild_destroy.yaml
```
