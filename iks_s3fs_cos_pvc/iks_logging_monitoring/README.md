# Container Logging and Monitoring Setup

This module will automatically deploy Logging and Mornitoring agents onto your Kubernetes on VPC Cluster. You can either bring your own logging and monitoring instances or provision them with this architecture. This can be run on [IBM Schematics](https://cloud.ibm.com/schematics) or in your local environment.

![Logging Monitoring](../.docs/logging-monitoring-basic.png)

---

### Table of Contents
1. [About](##about)
2. [Setup](##setup)
2. [Module Variables](##Module-Variables)
3. [Outputs](##Outputs) (optional)
4. [As a Module in a Larger Architecture](##As-a-Module-in-a-Larger-Architecture)

---

## About

This module allows you to get detailed service logs from your kubernetes cluster using logging and monitoring services:

### Logging

From the moment you provision a cluster with IBM Cloud Kubernetes Service, you want to know what is happening inside the cluster. You need to access logs to troubleshoot problems and pre-empt issues. At any time, you want to have access to different types of logs such as worker logs, pod logs, app logs, or network logs. In addition, you want to monitor different sources of log data in your Kubernetes cluster. Therefore, your ability to manage and access log records from any of these sources is critical. Your success managing and monitoring logs depends on how you configure the logging capabilities for your Kubernetes platform.<sup>[[1]](https://cloud.ibm.com/docs/services/Log-Analysis-with-LogDNA/tutorials?topic=LogDNA-kube)</sup>

### Monitoring

IBM Cloud™ Monitoring with Sysdig is a third-party cloud-native, and container-intelligence management system that you can include as part of your IBM Cloud architecture. Use it to gain operational visibility into the performance and health of your applications, services, and platforms. It offers administrators, DevOps teams, and developers full stack telemetry with advanced features to monitor and troubleshoot, define alerts, and design custom dashboards. IBM Cloud Monitoring with Sysdig is operated by Sysdig in partnership with IBM.<sup>[[2]](https://cloud.ibm.com/docs/services/Monitoring-with-Sysdig/tutorials?topic=Sysdig-about)</sup>

### Additional Resources

- [More about Log Analysis](https://cloud.ibm.com/docs/services/Log-Analysis-with-LogDNA)
- [More about Monitoring with Sysdig](https://cloud.ibm.com/docs/services/Monitoring-with-Sysdig)

---

## Setup

In orger to install Logging and Monitoring agensts on your cluster you will need access to the LogDNA Docker Image and the Sysdig Agent. In order to make sure these images can be used without the cluster being connected to the public internet, copies of these images need to be created in [IBM Container Registry](https://cloud.ibm.com/docs/Registry?topic=registry-registry_overview).

### Prerequisites

- [Docker](https://www.docker.com/) running on your local machine

### Creating the Logging Agent Image

1. Pull the image from Docker:
```
$ docker pull logdna/logdna-agent:latest
```
2. Tag the pulled image with the region of your IBM Container Registry, your registry namespace, the name for your new repo, and a tag for the new repo. 
```
$ docker tag logdna/logdna-agent:latest <region>.icr.io/<my_namespace>/<image_repo>:<tag>
```
Example:
```
$ docker tag logdna/logdna-agent:latest us.icr.io/asset-development/logdna:latest
```

3. Push your tagged image to the ICR Namespace. Make sure you're target the IBM Cloud region where you want to be able to access your new repository.
```
$ ibmcloud cr login
```
4. Push your image to the IBM Container Registry
```
$ docker push <region>.icr.io/<my_namespace>/<image_repo>:<tag>
```
5. Verify that your image was pushed successfully
```
ibmcloud cr image-list
```

### Creating the Monitoring Agent Image

1. Pull the image from Docker:
```
$ docker pull icr.io/ext/sysdig/agent:latest
```
2. Tag the pulled image with the region of your IBM Container Registry, your registry namespace, the name for your new repo, and a tag for the new repo. 
```
$ docker tag icr.io/ext/sysdig/agent:latest <region>.icr.io/<my_namespace>/<image_repo>:<tag>
```
Example:
```
$ docker tag icr.io/ext/sysdig/agent:latest us.icr.io/asset-development/logdna:latest
```
3. Push your tagged image to the ICR Namespace. Make sure you're target the IBM Cloud region where you want to be able to access your new repository.
```
$ ibmcloud cr login
```
4. Push your image to the IBM Container Registry
```
$ docker push <region>.icr.io/<my_namespace>/<image_repo>:<tag>
```
5. Verify that your image was pushed successfully
```
ibmcloud cr image-list
```


---
## Module Variables

Variable | Type | Description | Default
---------|------|-------------|--------
`ibmcloud_api_key` | String | The IBM Cloud platform API key needed to deploy IAM enabled resources |
`generation` | String | Generation of VPC. Can be 1 or 2 | `2`
`ibm_region` | String | IBM Cloud region where all resources will be deployed |
`resource_group` | String | Name for IBM Cloud Resource Group where resources will be deployed | 
`cluster_name` | String | Name of the cluster where resources will be deployed | 
`bring_your_own_logging` | String | True or false. A logging instance will be created if `false` | `false`
`logging_instance_name` | String | Name of logging instance. Name of the instance to be created if not bringing your own instance, otherwise use the name of your existing instance | `cluster-logging`
`logging_agent_image` | String | ICR image link for logdna agent greated in [Creating the Logging Agent Image](###Creating-the-Logging-Agent-Image) | `uk.icr.io/asset-bp2i-test/logdna-agent:latest`
`logging_endpoint` | String | API endpoint prefix for LogDNA (private, public) | `private`
`logging_plan` | String | Only required when creating resource. Plan for logging instance. | `7-day`
`bring_your_own_monitor` | String | True or false. A monitor instance will be created if `false` | `false`
`monitor_name` | String | Name of monitoring instance. Name of the instance to be created if not bringing your own instance, otherwise use the name of your existing instance | `cluster-monitoring`
`monitor_endpoint` | String | API endpoint prefix for Sysdig (private, public, direct) | `private`
`monitor_agent_image` | String | ICR image link for monitoring agent created in in [Creating the Monitoring Agent Image](###Creating-the-Monitoring-Agent-Image)  | `icr.io/ext/sysdig/agent:latest`
`monitor_plan` | String | Only required when creating resource. Plan for logging instance. | `graduated-tier`
`tags` | String | (Optional) List of tags for resource creation | `[]`
`service_end_points` | String | Sets the endpoints for the resources if not bringing your own. Can be `public` or `private` | `private`
---
## Outputs

Name | Value
-----|--------
`logging_id` |  The ID of the logging instance
`monitoring_id` |  The ID of the monitoring instance