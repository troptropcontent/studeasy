# frozen_string_literal: true

# the Quote holds the price of the assessment and will be the base for stripe checkouts
class Quote < ApplicationRecord
  belongs_to :assessment
  belongs_to :service_provider, optional: true, class_name: 'User'
  monetize :price_cents

  def to_partial_path
    "#{super}_#{status}"
  end

  def status
    return 'ready' unless price_cents.zero?

    'not_started'
  end
end
