class Order < ApplicationRecord
  belongs_to :quote
  monetize :amount_cents
  validates :quote_id, uniqueness: true
end
