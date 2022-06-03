# frozen_string_literal: true

require './app/services/stripe_checkout_session_service'

Stripe.api_key = Rails.application.credentials.dig(:stripe, Rails.env.to_sym, :private_key)
StripeEvent.signing_secret = Rails.application.credentials.dig(:stripe, Rails.env.to_sym, :webhook_secret)

StripeEvent.configure do |events|
  events.subscribe 'checkout.session.completed', StripeCheckoutSessionService.new
end
