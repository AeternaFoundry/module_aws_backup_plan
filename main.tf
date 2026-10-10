resource "aws_backup_plan" "backup_plans" {
  for_each = var.backup_plans

  name     = each.value.name
  region   = each.value.region
  tags     = each.value.tags
  tags_all = each.value.tags_all

  dynamic "rule" {
    for_each = each.value.rule
    content {
      completion_window = rule.value.completion_window
      dynamic "copy_action" {
        for_each = rule.value.copy_action != null ? rule.value.copy_action : []
        content {
          destination_vault_arn = copy_action.value.destination_vault_arn
          dynamic "lifecycle" {
            for_each = copy_action.value.lifecycle != null ? [copy_action.value.lifecycle] : []
            content {
              cold_storage_after                        = lifecycle.value.cold_storage_after
              delete_after                              = lifecycle.value.delete_after
              opt_in_to_archive_for_supported_resources = lifecycle.value.opt_in_to_archive_for_supported_resources
            }
          }
        }
      }
      enable_continuous_backup = rule.value.enable_continuous_backup
      dynamic "lifecycle" {
        for_each = rule.value.lifecycle != null ? [rule.value.lifecycle] : []
        content {
          cold_storage_after                        = lifecycle.value.cold_storage_after
          delete_after                              = lifecycle.value.delete_after
          opt_in_to_archive_for_supported_resources = lifecycle.value.opt_in_to_archive_for_supported_resources
        }
      }
      recovery_point_tags = rule.value.recovery_point_tags
      rule_name           = rule.value.rule_name
      dynamic "scan_action" {
        for_each = rule.value.scan_action != null ? rule.value.scan_action : []
        content {
          malware_scanner = scan_action.value.malware_scanner
          scan_mode       = scan_action.value.scan_mode
        }
      }
      schedule                                     = rule.value.schedule
      schedule_expression_timezone                 = rule.value.schedule_expression_timezone
      start_window                                 = rule.value.start_window
      target_logically_air_gapped_backup_vault_arn = rule.value.target_logically_air_gapped_backup_vault_arn
      target_vault_name                            = rule.value.target_vault_name
    }
  }

  dynamic "advanced_backup_setting" {
    for_each = each.value.advanced_backup_setting != null ? each.value.advanced_backup_setting : []
    content {
      backup_options = advanced_backup_setting.value.backup_options
      resource_type  = advanced_backup_setting.value.resource_type
    }
  }

  dynamic "scan_setting" {
    for_each = each.value.scan_setting != null ? each.value.scan_setting : []
    content {
      malware_scanner  = scan_setting.value.malware_scanner
      resource_types   = scan_setting.value.resource_types
      scanner_role_arn = scan_setting.value.scanner_role_arn
    }
  }
}

