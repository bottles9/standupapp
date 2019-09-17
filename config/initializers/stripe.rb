Rails.configuration.stripe = {
publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
secret_key: ENV['STRIPE_API_KEY']
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]
StripeEvent.signing_secret = ENV['STRIPE_SIGNING_SECRET']
StripeEvent.event_filter = lambda do |params|
return nil if StripeWebhook.exists?(stripe_event_id: params[:id])
StripeWebhook.create!(stripe_event_id: params[:id])
{id: params[:id], type: params[:type]}
end
StripeEvent.configure do |events|
events.subscribe(
'invoice.payment_succeeded',
::Events::Stripe::InvoicePaymentSucceeded.new
)
events.subscribe(
'invoice.payment_failed',
::Events::Stripe::InvoicePaymentFailed.new
)
events.subscribe(
'invoice.upcoming',
::Events::Stripe::InvoiceUpcoming.new
)
events.subscribe(
'customer.subscription.trial_will_end',
::Events::Stripe::CustomerSubscriptionTrialWillEnd.new
)
events.subscribe(
'customer.subscription.deleted',
::Events::Stripe::CustomerSubscriptionDeleted.new
)
end
