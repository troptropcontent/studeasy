# frozen_string_literal: true

# the Quote holds the price of the assessment and will be the base for stripe checkouts
class Quote < ApplicationRecord
  belongs_to :assessment
  belongs_to :service_provider, optional: true
  monetize :price_cents
  enum status: { not_started: 0, ready: 1, paid: 2 }

  def to_partial_path
    "#{super}_#{status}"
  end
end
