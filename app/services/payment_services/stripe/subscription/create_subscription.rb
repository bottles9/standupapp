module PaymentServices
module Stripe
module Subscription
class CreateSubscription
include StripeSubscription
def initialize(params)
@customer = params[:customer]
@account = params[:account]
@plan = params[:plan]
@attributes = {}
@subscription = {}
@uuid = SecureRandom.uuid
end
def self.call(params)
new(params).send(:perform)
end
private
attr_reader :customer, :account, :plan, :token, :uuid
attr_accessor :attributes, :subscription
def perform
create_stripe_subscription
rescue ActiveRecord::RecordInvalid, ::Stripe::StripeError => exception
OpenStruct.new(
success?: false,
subscription: subscription,
error: exception.message
)
else
OpenStruct.new(success?: true, subscription: subscription)
end
def create_stripe_subscription
@subscription = ::Stripe::Subscription.create(
{
customer: customer.is_a?(String) ? customer : customer.id,
plan: plan
},
idempotency_key: uuid
)
save_subscription_object
end
end
end
end
end
