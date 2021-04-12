############################################################
# INPUT VARIABLES
############################################################
variable "namespace" {
  type        = string
  default     = "clusterload"
  description = "Namespace used for deploying the clusterload objects. This namespace has to exist and is not provisioned by this module"
}

variable "clusterload_quota_pods" {
  type        = string
  default     = "20"
  description = "Limit for the number of Pods that can be created in this namespace."
}

variable "clusterload_quota_cpu_request" {
  type        = string
  default     = "2"
  description = "Maximum for CPU requests. The total amount of CPU requests across all active Pods cannot exceed this value."
}

variable "clusterload_quota_cpu_limit" {
  type        = string
  default     = "4"
  description = "Maximum for CPU limits. The total amount of CPU limits across all active Pods cannot exceed this value."
}

variable "clusterload_quota_memory_request" {
  type        = string
  default     = "16Gi"
  description = "Maximum for memory requests. The total amount of memory requests across all active Pods cannot exceed this value."
}

variable "clusterload_quota_memory_limit" {
  type        = string
  default     = "32Gi"
  description = "Maximum for memory limits. The total amount of memory limits across all active Pods cannot exceed this value."
}

variable "clusterload_configurations" {
  type    = list(object({
    pod_name     = string
    pod_replicas = number
    containers   = list(object({
      name        = string
      run_type    = string
      run_scaler  = string
      run_value   = string
      cpu_request = string
      cpu_limit   = string
      mem_request = string
      mem_limit   = string
    }))
  }))
  default = [{
    pod_name = "clusterload"
    pod_replicas = 1
    containers = [
      {
      name = "cpuload"
      run_type = "cpu"
      run_scaler = "CPU_PERCENT"
      run_value = "10"
      cpu_request = "240m"
      cpu_limit = "250m"
      mem_request = "100Mi"
      mem_limit = "128Mi"
      },
      {
      name = "memload"
      run_type= "memory"
      run_scaler = "MEMORY_NUM"
      run_value = "250"
      cpu_request = "50m"
      cpu_limit = "1"
      mem_request = "1Gi"
      mem_limit = "1Gi"
      },
    ]
  }]
  description = "This is the configuratin of the clusterload Deployment(s). One Deployment is created for each entry in the list. It is possible to tune the values, such as requests, limits, and utilization of each container that will be created."
}
