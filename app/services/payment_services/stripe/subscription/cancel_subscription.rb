module PaymentServices
module Stripe
module Subscription
class CancelSubscription
def initialize(params)
@subscription = params[:subscription]
@uuid = SecureRandom.uuid
end
def self.call(params)
new(params).send(:perform)
end
private
attr_reader :uuid
attr_accessor :subscription
def perform
cancel_stripe_subscription
rescue ActiveRecord::RecordInvalid, ::Stripe::StripeError => exception
OpenStruct.new(
success?: false,
subscription: subscription,
error: exception.message
)
else
OpenStruct.new(success?: true, subscription: subscription)
end
def cancel_stripe_subscription
  subscription_id = subscription
@subscription = ::Stripe::Subscription.retrieve(subscription)
@subscription = @subscription.delete(
{},
idempotency_key: uuid
)
save_subscription(subscription_id)
end
def save_subscription(subscription_id)
::Subscription.find_by(stripe_subscription_id: subscription_id)
.update!(
stripe_subscription_id: nil,
plan_id: nil,
status: subscription.status,
idempotency_key: uuid
)
end
end
end
end
end
