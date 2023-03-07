locals {
  restricted_role_uuids = flatten([
    for role_name in var.restricted_roles : [
      for role in data.datadog_roles.default.roles : role.id if lower(role.name) == lower(role_name)
    ]
  ])
}

data "datadog_roles" "default" {}

resource "datadog_dashboard_list" "default" {
  count = var.dashboard_list_name != null ? 1 : 0
  name  = var.dashboard_list_name
}

resource "datadog_dashboard" "default" {
  for_each         = { for k, v in var.dashboards : v.title => v if lookup(v, "json", null) == null }
  title            = each.value.title
  dashboard_lists  = [datadog_dashboard_list.default.0.id]
  description      = each.value.description
  layout_type      = try(each.value.layout_type, "free")
  restricted_roles = local.restricted_role_uuids

  lifecycle {
    ignore_changes = [
      template_variable,
      template_variable_preset,
      widget,
    ]
  }
}

resource "datadog_dashboard_json" "default" {
  for_each        = { for k, v in var.dashboards : v.title => v if lookup(v, "json", null) != null }
  dashboard       = each.value["json"]
  dashboard_lists = [datadog_dashboard_list.default.0.id]
}
