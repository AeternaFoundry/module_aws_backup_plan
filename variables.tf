variable "backup_plans" {
  description = <<EOT
Map of backup_plans, attributes below
Required:
    - name
    - rule (block):
        - completion_window (optional)
        - copy_action (optional, block):
            - destination_vault_arn (required)
            - lifecycle (optional, block):
                - cold_storage_after (optional)
                - delete_after (optional)
                - opt_in_to_archive_for_supported_resources (optional)
        - enable_continuous_backup (optional)
        - lifecycle (optional, block):
            - cold_storage_after (optional)
            - delete_after (optional)
            - opt_in_to_archive_for_supported_resources (optional)
        - recovery_point_tags (optional)
        - rule_name (required)
        - scan_action (optional, block):
            - malware_scanner (required)
            - scan_mode (required)
        - schedule (optional)
        - schedule_expression_timezone (optional)
        - start_window (optional)
        - target_logically_air_gapped_backup_vault_arn (optional)
        - target_vault_name (required)
Optional:
    - region
    - tags
    - tags_all
    - advanced_backup_setting (block):
        - backup_options (required)
        - resource_type (required)
    - scan_setting (block):
        - malware_scanner (required)
        - resource_types (required)
        - scanner_role_arn (required)
EOT

  type = map(object({
    name     = string
    region   = optional(string)
    tags     = optional(map(string))
    tags_all = optional(map(string))
    rule = list(object({
      completion_window = optional(number)
      copy_action = optional(list(object({
        destination_vault_arn = string
        lifecycle = optional(object({
          cold_storage_after                        = optional(number)
          delete_after                              = optional(number)
          opt_in_to_archive_for_supported_resources = optional(bool)
        }))
      })))
      enable_continuous_backup = optional(bool)
      lifecycle = optional(object({
        cold_storage_after                        = optional(number)
        delete_after                              = optional(number)
        opt_in_to_archive_for_supported_resources = optional(bool)
      }))
      recovery_point_tags = optional(map(string))
      rule_name           = string
      scan_action = optional(list(object({
        malware_scanner = string
        scan_mode       = string
      })))
      schedule                                     = optional(string)
      schedule_expression_timezone                 = optional(string)
      start_window                                 = optional(number)
      target_logically_air_gapped_backup_vault_arn = optional(string)
      target_vault_name                            = string
    }))
    advanced_backup_setting = optional(list(object({
      backup_options = map(string)
      resource_type  = string
    })))
    scan_setting = optional(list(object({
      malware_scanner  = string
      resource_types   = set(string)
      scanner_role_arn = string
    })))
  }))
  validation {
    condition = alltrue([
      for k, v in var.backup_plans : (
        length(v.rule) >= 1
      )
    ])
    error_message = "Each rule list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.backup_plans : (
        v.scan_setting == null || alltrue([for item in v.scan_setting : (alltrue([for x in item.resource_types : can(regex("^[a-zA-Z0-9\\-\\_\\.]{1,50}$", x))]))])
      )
    ])
    error_message = "must contain only alphanumeric characters, hyphens, underscores, and periods"
  }
  # Note: 9 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

