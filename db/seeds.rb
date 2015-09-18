# any commands in this file should be idempotent
Role.find_or_create_by(name: 'observer')
Role.find_or_create_by(name: 'client_admin')
Role.find_or_create_by(name: 'admin')

User.with_email_role_slug!(
  ENV['NCR_BA61_TIER1_BUDGET_MAILBOX'] || 'communicart.budget.approver@gmail.com',
  'BA61_tier1_budget_approver',
  'ncr'
)
User.with_email_role_slug!(
  ENV['NCR_BA61_TIER2_BUDGET_MAILBOX'] || 'communicart.ofm.approver@gmail.com',
  'BA61_tier2_budget_approver',
  'ncr'
)
User.with_email_role_slug!(
  ENV['NCR_BA80_BUDGET_MAILBOX'] || 'communicart.budget.approver@gmail.com',
  'BA80_budget_approver',
  'ncr'
)
User.with_email_role_slug!(
  ENV['NCR_OOL_BA80_BUDGET_MAILBOX'] || 'communicart.budget.approver@gmail.com',
  'OOL_BA80_budget_approver',
  'ncr'
)
