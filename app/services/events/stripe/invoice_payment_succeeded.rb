module Events
module Stripe
class InvoicePaymentSucceeded
def call(event)
::Payments::InvoicePaymentSucceeded.email(event[:id]).deliver_later
end
end
end
end
