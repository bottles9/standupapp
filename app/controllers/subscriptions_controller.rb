class SubscriptionsController < ApplicationController
def create
response = update_subscription_service
if response.success?
redirect_to(root_path, info: 'Plan was successfully added!')
else
logger.info "[STRIPE] Problem updating subscription: #{response.error}"
redirect_to(
plan_path(params[:plan]),
notice: 'Plan was not able to be added!'
)
end
end
def destroy
response = delete_subscription_service
if response.success?
redirect_to(billing_index_path, notice: 'Plan has been canceled.')
else
logger.info "[STRIPE] Problem cancelling subscription: #{response.error}"
redirect_to(billing_index_path, notice: 'Plan unable to be canceled.')
end
end
private
def update_subscription_service
@update_subscription_service ||=
PaymentServices::Stripe::Subscription::UpdateSubscription.(
account: current_account,
plan: params[:plan],
token: params[:stripeToken]
)
end
def delete_subscription_service
@delete_subscription_service ||=
PaymentServices::Stripe::Subscription::CancelSubscription.(
subscription: params[:id]
)
end
end
