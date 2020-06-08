# S3FS COS PVC

This module uses Kubernetes and Helm to create a kubernetes PVC using a COS bucket as storage. Optionally, you can bring your own COS instance.

![arch image](../.docs/cos_pvc.png)
---

### Table of Contents
1. Resource headers
2. [Module Variables](##Module-Variables)
3. [Outputs](##Outputs) (optional)
4. [As a Module in a Larger Architecture](##As-a-Module-in-a-Larger-Architecture)

---

## s3fs Install

This part of the module sets up the IKS cluster for the installation of the IBM Cloud Object Storage Plugin and installs it
- Copies the ICR image pull secrets from the `default` namespace into `kube-system` to allow the tiller instance to create the plugin
- Creates a cluster role binding to allow the tiller instance to install the plugin
- Creates a data source for `ibm-charts` repo in helm
- Creates a release for the IBM COS Plugin once the binding has been applied
- Outputs the status of the helm release

## COS PVC

This part of the module creates a COS Bucket, Resource Key, and the PVC
- (Optionally) creates a new COS instance
- When the helm release is completed, it creates an HMAC key for COS
- Once the resource key has been created, creates a new COS bucket
- Uses [fetch_hmac_key.sh](./cos_pvc/fetch_hmac_key.sh) to get the secret data as a data source
- Uses the secret data to create a `cos-write-access` secret to allow the PVC to use COS
- Creates the COS PVS

---
## Module Variables

Variable | Type | Description | Default
---------|------|-------------|--------
`ibmcloud_api_key` | String | The IBM Cloud platform API key needed to deploy IAM enabled resources |
`generation` | String | Generation of VPC. Can be 1 or 2 | `1`
`ibm_region` | String | IBM Cloud region where all resources will be deployed | `eu-gb`
`resource_group` | String | Name for IBM Cloud Resource Group | `asset-development`
`cluster_name` | String | Name of the cluster where resources will be deployed | `asset-dev-cluster`
`bring_your_own_cos` | Boolean | Bring your own COS instance. If false, one will be created for you | `false`
`cos_name` | String | Name of cos instance to be created | `s3fs-cos`
`cos_bucket_name` | String | Name of cos bucket to be shared by resources | `test-bucket-for-tests`
`storage_class` | String | Storage class of the PVC to be created | `ibmc-s3fs-standard-perf-regional`

