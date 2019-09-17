module Payments
class InvoiceUpcoming < ApplicationMailer

default from: "'Standup App' <billing@app.buildasaasappinrails.com>"
layout 'payment_mailer'
def email(event)
event = ::Stripe::Event.retrieve(event)
subscription = obtain_subscription(event)
user = subscription.account.users.order(created_at: :asc).first
@title = 'A Payment to Standup App is coming up!'
create_message(event)
mail(to: user.email, subject: @title)
rescue NoMethodError, Stripe::InvalidRequestError
logger.info "[Stripe] No subscription record found for account \
#{event.data.object.subscription}"
end
private
def obtain_subscription(event)
subscription = event.data.object.subscription
Subscription.find_by(stripe_subscription_id: subscription)
end
def create_message(event)
@message = "Your account has a payment coming up. The payment will be for\
the amount of #{Money.new(event.data.object.amount_due).format}\
and will be processed on\
#{Time.at(event.data.object.next_payment_attempt)}"
end
end
end
