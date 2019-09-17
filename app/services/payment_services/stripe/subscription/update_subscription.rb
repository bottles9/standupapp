module PaymentServices
module Stripe
module Subscription
class UpdateSubscription
include StripeSubscription
def initialize(params)
@token = params[:token]
@account = params[:account]
@customer = {}
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
update_stripe_subscription
rescue ActiveRecord::RecordInvalid, ::Stripe::StripeError => exception
OpenStruct.new(
success?: false,
subscription: subscription,
error: exception.message
)
else
OpenStruct.new(success?: true, subscription: subscription)
end
def update_stripe_subscription
@customer = ::Stripe::Customer.retrieve(
@account.subscription.stripe_customer_id
)
update_source if token
customer.update_subscription(
{
plan: plan,
},
idempotency_key: uuid
)
@subscription = customer.subscriptions.first
save_subscription_object
end
def update_source
@customer = customer.save(
{source: token},
idempotency_key: SecureRandom.uuid
)
end
def merge_token_attributes
card = ::Stripe::Token.retrieve(token).card
attributes.merge!(
stripe_token: token,
card_last4: card.last4,
card_expiration: "#{card.exp_month}/#{card.exp_year}",
card_type: card.brand
)
end
end
end
end
end
