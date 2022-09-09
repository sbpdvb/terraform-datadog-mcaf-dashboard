variable "dashboard_list_name" {
  type        = string
  default     = null
  description = "Name of the dashboard list to create for the dashboards (Optional)"
}

variable "dashboards" {
  type        = list(map(string))
  default     = []
  description = "List of dashboards to create and optionally add to the dashboard list"
}

variable "restricted_roles" {
  type        = list(string)
  default     = []
  description = "List of role names that are authorised to edit the dashboard"
}
