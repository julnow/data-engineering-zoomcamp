variable "credentials" {
  description = "My Credentials"
  default     = "./creds/creds.json"
  #ex: if you have a directory where this file is called keys with your service account json file
  #saved there as my-creds.json you could use default = "./keys/my-creds.json"
}


variable "project" {
  description = "Project"
  default     = "earnest-topic-412511"
}

variable "region" {
  description = "Region"
  #Update the below to your desired region
  default = "europe-central2"
}

variable "location" {
  description = "Project Location"
  #Update the below to your desired location
  default = "europe-central2"
}

variable "bq_dataset_name" {
  description = "Terraform demo dataset"
  #Update the below to what you want your dataset to be called
  default = "terraform_demo_dataset"
}

variable "gcs_bucket_name" {
  description = "Terraform bucker run 1 demo"
  #Update the below to a unique bucket name
  default = "terraform-demo-terra-bucket-run1"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}