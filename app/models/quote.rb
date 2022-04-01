class Quote < ApplicationRecord
  belongs_to :assessment
  belongs_to :service_provider, optional: true
  monetize :price_cents
end
