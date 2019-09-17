class CardsController < ApplicationController
def create
  response = stripe_card_service
handle_response(response: response,
success_message: 'Card was successfully updated.',
failure_message: 'Card was not successfully updated.')
end
private
def stripe_card_service
@stripe_card_service ||=
PaymentServices::Stripe::Card::CreateCard.(
token: params[:stripeToken],
account: current_account
)
end
end
