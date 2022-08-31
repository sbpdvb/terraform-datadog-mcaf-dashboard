# terraform-datadog-mcaf-dashboard

Terraform module to create Datadog dashboards and (optionally) create and add them to a Datadog dashboard list.

`dashboards` accepts a list of objects that must contain `title` and `description` keys, and can optionally include a `layout_type` type if you want to deviate from the default value which is `free` as shown in this example:

```hcl
locals {
  dashboards = [
    {
      title       = "My Dashboard"
      description = "Show all the things"
    }
  ]
}

module "datadog_dashboards" {
  source              = "github.com/schubergphilis/terraform-datadog-mcaf-dashboard"
  dashboard_list_name = "My Dashboards"
  dashboards          = local.dashboards
  restricted_roles    = ["My Role"]
}
```

There is also the option to manage the dashboard using Terraform by exporting the JSON and adding to the dashboard object using a `json` key:

```hcl
locals {
  dashboards = [
    {
      title = "My Dashboard"
      json  = file("${path.root}/mydashboard.json")
    }
  ]
}

module "datadog_dashboards" {
  source              = "github.com/schubergphilis/terraform-datadog-mcaf-dashboard"
  dashboard_list_name = "My Dashboards"
  dashboards          = local.dashboards
  restricted_roles    = ["My Role"]
}
```

<!--- BEGIN_TF_DOCS --->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| datadog | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dashboard\_list\_name | Name of the dashboard list to create for the dashboards (Optional) | `string` | `null` | no |
| dashboards | List of dashboards to create and optionally add to the dashboard list | `list(map(string))` | `[]` | no |
| restricted\_roles | List of role names that are authorised to edit the dashboard | `list(string)` | `[]` | no |

## Outputs

No output.

<!--- END_TF_DOCS --->
