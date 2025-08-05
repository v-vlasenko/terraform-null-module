/**
 * # terraform-null-module
 * !
 * Module `terraform-null-module` is a demonstration module,
 * consisting of a single `null_resource` resource.
 *
 * This module ultimately does nothing, but can be used to do an
 * end-to-end test of Terraform's registry functionality.
 * 
 * Usage Example:
 * 
 *     module "null_module" {
 *       source  = "vancluever/module/null"
 *       version = "2.0.2"
 *       trigger = "one"
 *     }
 * 
 */

variable "trigger" {
  description = "The trigger value for the `null_resource` resource in this module."
  default     = "one"
}

output "null_resource_id" {
  description = "The `id` of the `null_resource` resource in this module."
  value       = "${null_resource.resource.id}"
}
