$(document).on 'turbolinks:load', ->
  if $('#card.content').length
    elements = stripe.elements()
    style =
      base:
        color: '#32325d'
        lineHeight: '24px'
        fontFamily: '"Helvetica Neue", Helvetica, sans-serif'
        fontSmoothing: 'antialiased'
        fontSize: '16px'
        '::placeholder': color: '#aab7c4'
      invalid:
        color: '#fa755a'
        iconColor: '#fa755a'
    # Create an instance of the card Element
    card = elements.create('card', style: style)
    # Add an instance of the card Element into the `card-element` <div>

    stripeTokenHandler = (token) ->
      # Insert the token ID into the form so it gets submitted to the server
      form = document.getElementById('payment-form')
      hiddenInput = document.getElementById("stripeToken")
      hiddenInput.value = token.id
      # Submit the form
      form.submit()

    card.mount '#card-element'
    card.addEventListener 'change', (event) ->
      displayError = document.getElementById('card-errors')
      if event.error
        displayError.textContent = event.error.message
      else
        displayError.textContent = ''

    form = document.getElementById('payment-form')
    form.addEventListener 'submit', (event) ->
      event.preventDefault()
      extraDetails =
        name: form.querySelector('input[name=cardholder-name]').value,
      stripe.createToken(card, extraDetails).then (result) ->
        if result.error
          # Inform the user if there was an error
          errorElement = document.getElementById('card-errors')
          errorElement.textContent = result.error.message
        else
          # Send the token to your server
          stripeTokenHandler result.token
