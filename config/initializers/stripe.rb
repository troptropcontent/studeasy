# frozen_string_literal: true

Stripe.api_key = Rails.application.credentials.dig(:stripe, Rails.env.to_sym, :private_key)
