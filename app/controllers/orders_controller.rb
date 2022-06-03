# frozen_string_literal: true

# order for stripe
class OrdersController < ApplicationController
  def create
    quote = Quote.find(order_params[:quote_id])
    @order = Order.create_with(amount: quote.price).find_or_create_by!(quote: quote)

    create_or_retrive_checkout_session(quote)

    respond_to do |format|
      format.html { redirect_to @session.url, allow_other_host: true }
    end
  end

  private

  def order_params
    params.require(:order).permit(:quote_id)
  end

  def create_or_retrive_checkout_session(quote)
    if @order.checkout_session_id.present?
      @session = Stripe::Checkout::Session.retrieve(@order.checkout_session_id)
    else
      create_stripe_session(quote)
    end
  end

  def create_stripe_session(quote)
    @session = Stripe::Checkout::Session.create(**stripe_session_attributes(quote))

    @order.update!(checkout_session_id: @session.id, status: :pending)
  end

  def stripe_session_attributes(quote)
    { payment_method_types: ['card'],
      line_items: [{
        name: quote.assessment.name,
        amount: quote.price_cents,
        currency: 'eur',
        quantity: 1
      }],
      success_url: assessment_url(@order.quote.assessment),
      cancel_url: assessment_url(@order.quote.assessment) }
  end
end
