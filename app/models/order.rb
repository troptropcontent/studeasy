# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :quote
  monetize :amount_cents
  validates :quote_id, uniqueness: true
  enum status: %i[created pending paid]
end
