module Payments
class InvoicePaymentSucceeded < ApplicationMailer
default from: "'Standup App' <billing@app.buildasaasappinrails.com>"
layout 'payment_mailer'
def email(event)
event = ::Stripe::Event.retrieve(event)
subscription = obtain_subscription(event)
user = subscription.account.users.order(created_at: :asc).first
@title = 'Payment to Standup App Successful!'
create_message(event)
mail(to: user.email, subject: @title)
rescue NoMethodError
logger.info "[Stripe] No subscription record found for account \
#{event.data.object.subscriptionn}"
end
private
def obtain_subscription(event)
subscription = event.data.object.subscription
Subscription.find_by(stripe_subscription_id: subscription)
end
def create_message(event)
@message = "Thank you for your payment of \
#{Money.new(event.data.object.amount_due).format}\
that was processed on #{Time.at(event.data.object.date)}.
"
end
end
end
