class Assessment < ApplicationRecord
  belongs_to :user
  has_many_attached :document
end
