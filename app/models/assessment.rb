# frozen_string_literal: true

# Assement is the base product
class Assessment < ApplicationRecord
  belongs_to :user
  has_many_attached :documents
  has_one :quote, dependent: :destroy
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

  scope :to_do, lambda {
                  left_joins(quote: { solution: :documents_attachments }).where(solution: { id: nil })
                }
  scope :in_progress, lambda {
                        left_joins(quote: { solution: :documents_attachments })
                          .where.not(solution: { id: nil }).where(documents_attachments: nil)
                      }
  scope :past, -> { joins(quote: { solution: :documents_attachments }) }

  def status
    return 'waiting_for_quotation' if quote.price.zero?
    return 'waiting_for_payment' if quote.order.nil? || !quote.order.paid?

    'paid'
  end

  def quote
    super || Quote.create!(assessment: self, price: 0)
  end
end
