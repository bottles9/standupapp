module PaymentServices
module Stripe
module Subscription
class CreationService
def initialize(params)
@user = params[:user]
@account = params[:account]
@plan = params[:plan]
@customer = {}
end
def self.call(params)
new(params).send(:perform)
end
private
attr_reader :user, :account, :plan
attr_accessor :customer
def perform
create_stripe_customer
create_subscription_service
rescue ActiveRecord::RecordInvalid, ::Stripe::StripeError => exception
OpenStruct.new(success?: false, error: exception.message)
else
OpenStruct.new(success?: true)
end
def create_stripe_customer
uuid = SecureRandom.uuid
@customer = ::Stripe::Customer.create(
{
description: "Customer for #{account.name}",
email: user.email
},
idempotency_key: uuid
)
end
def create_subscription_service
PaymentServices::Stripe::Subscription::CreateSubscription.(
customer: customer,
account: account,
plan: plan
)
end
end
end
end
end
