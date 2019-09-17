module PaymentServices
module Stripe
module Subscription
module StripeSubscription
def customer_id
customer.is_a?(String) ? customer : customer.id
end
def subscription_attributes
{
account_id: account.id,
plan_id: plan,
stripe_customer_id: customer_id,
start: subscription.start,
status: subscription.status,
stripe_subscription_id: subscription.id,
idempotency_key: uuid
}
end
def save_subscription_object
@attributes = subscription_attributes
merge_token_attributes if token
sub = ::Subscription.find_or_create_by(
stripe_customer_id: customer_id
)
sub.update_attributes(attributes)
end
end
end
end
end
