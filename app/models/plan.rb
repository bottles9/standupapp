class Plan
def self.plans
@plans ||= PLANS.keys.map { |k| PLANS[k] }
end
def self.all
plans.map { |plan| OpenStruct.new(plan) }
end
def self.where(args)
conditions = args.map do |arg_key, arg_val|
proc { |plan| plan[arg_key] == arg_val }
end
local_plans = plans.select { |plan| conditions.all? { |c| c.call(plan) } }
local_plans.flatten.map { |plan| OpenStruct.new(plan) }
end
def self.find(stripe_id)
plan = plans.find { |p| p[:stripe_id] == stripe_id }
OpenStruct.new(plan)
end
end
