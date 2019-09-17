class BillingController < ApplicationController
def index
render :index and return if current_subscription.nil?
begin
@charges =
Stripe::Charge.list(
customer: current_subscription.stripe_customer_id
).data
rescue Stripe::InvalidRequestError
@charges = []
end
end
def change_card
end
end
