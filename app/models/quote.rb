# frozen_string_literal: true

# the Quote holds the price of the assessment and will be the base for stripe checkouts
class Quote < ApplicationRecord
  belongs_to :assessment
  belongs_to :service_provider, optional: true
  monetize :price_cents
end
