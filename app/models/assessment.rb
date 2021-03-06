# frozen_string_literal: true

# Assement is the base product
class Assessment < ApplicationRecord
  belongs_to :user
  has_many_attached :documents
  has_one :quote
  has_rich_text :description

  validates :deadline, presence: true
  validates :name, presence: true
  validates :documents, attached: true,
                        limit: { min: 1, max: 3 },
                        content_type: [
                          'application/pdf',
                          'application/msword',
                          'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
                        ],
                        size: { between: (1.kilobyte)..(100.megabytes) }

  def status
    return 'waiting for quotation' unless quote
    return 'assigned' if service_provider

    'quoted'
  end
end
