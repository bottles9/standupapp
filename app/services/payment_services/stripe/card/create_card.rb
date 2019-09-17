module PaymentServices
module Stripe
module Card
class CreateCard
def initialize(params)
@token = params[:token]
@account = params[:account]
@card = {}
@uuid = SecureRandom.uuid
end
def self.call(params)
new(params).send(:perform)
end
private
attr_reader :account, :token, :uuid
attr_accessor :card
def perform
create_card
rescue ActiveRecord::RecordInvalid, ::Stripe::StripeError => exception
OpenStruct.new(
success?: false,
error: exception.message
)
else
OpenStruct.new(success?: true, subscription: account.subscription)
end
def create_card
customer = ::Stripe::Customer.retrieve(
account.subscription.stripe_customer_id
)
customer.sources.retrieve(account.subscription.stripe_token).delete
@card = customer.sources.create(
{ source: token },
idempotency_key: uuid
)
update_subscription
end
def update_subscription
account.subscription.tap do |sub|
sub.stripe_token = card.id
sub.card_last4 = card.last4
sub.card_expiration = "#{card.exp_month}/#{card.exp_year}"
sub.card_type = card.brand
end
account.subscription.save!
end
end
end
end
end
