module StripeSync
module Plans
def self.sync!
remote_plans = Stripe::Plan.all
Plan.all.each do |yml_plan|
if plan ||= remote_plans.find { |p| p.id == yml_plan[:stripe_id] }
plan.delete
end
create_plan(yml_plan)
end
end
def self.create_plan(yml_plan)
Stripe::Plan.create(
amount: yml_plan[:amount],
interval: yml_plan[:interval],
name: yml_plan[:human_name],
currency: 'usd',
trial_period_days: 14,
id: yml_plan[:stripe_id]
)
end
end
end
