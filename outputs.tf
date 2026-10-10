output "backup_plans_id" {
  description = "Map of id values across all backup_plans, keyed the same as var.backup_plans"
  value       = { for k, v in aws_backup_plan.backup_plans : k => v.id if v.id != null && length(v.id) > 0 }
}
output "backup_plans_advanced_backup_setting" {
  description = "Map of advanced_backup_setting values across all backup_plans, keyed the same as var.backup_plans"
  value       = { for k, v in aws_backup_plan.backup_plans : k => v.advanced_backup_setting if v.advanced_backup_setting != null && length(v.advanced_backup_setting) > 0 }
}
output "backup_plans_arn" {
  description = "Map of arn values across all backup_plans, keyed the same as var.backup_plans"
  value       = { for k, v in aws_backup_plan.backup_plans : k => v.arn if v.arn != null && length(v.arn) > 0 }
}
output "backup_plans_name" {
  description = "Map of name values across all backup_plans, keyed the same as var.backup_plans"
  value       = { for k, v in aws_backup_plan.backup_plans : k => v.name if v.name != null && length(v.name) > 0 }
}
output "backup_plans_region" {
  description = "Map of region values across all backup_plans, keyed the same as var.backup_plans"
  value       = { for k, v in aws_backup_plan.backup_plans : k => v.region if v.region != null && length(v.region) > 0 }
}
output "backup_plans_rule" {
  description = "Map of rule values across all backup_plans, keyed the same as var.backup_plans"
  value       = { for k, v in aws_backup_plan.backup_plans : k => v.rule if v.rule != null && length(v.rule) > 0 }
}
output "backup_plans_scan_setting" {
  description = "Map of scan_setting values across all backup_plans, keyed the same as var.backup_plans"
  value       = { for k, v in aws_backup_plan.backup_plans : k => v.scan_setting if v.scan_setting != null && length(v.scan_setting) > 0 }
}
output "backup_plans_tags" {
  description = "Map of tags values across all backup_plans, keyed the same as var.backup_plans"
  value       = { for k, v in aws_backup_plan.backup_plans : k => v.tags if v.tags != null && length(v.tags) > 0 }
}
output "backup_plans_tags_all" {
  description = "Map of tags_all values across all backup_plans, keyed the same as var.backup_plans"
  value       = { for k, v in aws_backup_plan.backup_plans : k => v.tags_all if v.tags_all != null && length(v.tags_all) > 0 }
}
output "backup_plans_version" {
  description = "Map of version values across all backup_plans, keyed the same as var.backup_plans"
  value       = { for k, v in aws_backup_plan.backup_plans : k => v.version if v.version != null && length(v.version) > 0 }
}

