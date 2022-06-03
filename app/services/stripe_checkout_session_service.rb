# frozen_string_literal: true

# This service handle the webhook receive from stripe and update the order accordingly
class StripeCheckoutSessionService
  def call(event)
    order = Order.find_by(checkout_session_id: event.data.object.id)
    order.update(status: 'paid')
  end
end
