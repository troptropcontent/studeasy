# frozen_string_literal: true

class Solution < ApplicationRecord
  belongs_to :quote
  belongs_to :user
  has_many_attached :documents

  enum status: { started: 0, finished: 1 }
end
