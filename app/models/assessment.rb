# frozen_string_literal: true

# Assement is the base product
class Assessment < ApplicationRecord
  belongs_to :user
  has_many_attached :documents
  has_one :quote, dependent: :destroy
  has_one :solution, through: :quote, dependent: :destroy
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

  scope :with_status, lambda {
    select('assessments.*, statuses.assessment_status as status')
      .joins(
        "JOIN (
        SELECT assessments.id as assessment_id,
        CASE
            WHEN quotes.price_cents = 0 OR quotes.id IS NULL THEN 'waiting_for_quotation'
            WHEN orders.status != 2 OR orders.id IS NULL THEN 'waiting_for_payment'
            WHEN orders.status = 2 AND solutions.id IS NULL THEN 'paid'
            WHEN solutions.id IS NOT NULL AND solution_attachements.id IS NULL THEN 'assigned'
            WHEN solutions.id IS NOT NULL AND solution_attachements.id IS NOT NULL THEN 'done'
            ELSE 'undefined'
        END AS assessment_status
        FROM assessments
        LEFT JOIN quotes ON quotes.assessment_id = assessments.id
        LEFT JOIN orders ON orders.quote_id = quotes.id
        LEFT JOIN solutions ON solutions.quote_id = quotes.id
        LEFT JOIN active_storage_attachments as solution_attachements ON solution_attachements.record_type = 'Solution' AND solution_attachements.name = 'documents' AND solution_attachements.record_id = solutions.id
      ) as statuses ON statuses.assessment_id = assessments.id"
      )
      .distinct
  }

  scope :waiting_for_quotation, -> { with_status.where(statuses: { assessment_status: 'waiting_for_quotation' }) }
  scope :waiting_for_payment, -> { with_status.where(statuses: { assessment_status: 'waiting_for_payment' }) }
  scope :paid, -> { with_status.where(statuses: { assessment_status: 'paid' }) }
  scope :assigned, -> { with_status.where(statuses: { assessment_status: 'assigned' }) }
  scope :done, -> { with_status.where(statuses: { assessment_status: 'done' }) }

  def status
    self.class.where(id: id).with_status.first[:status]
  end

  def quote
    super || Quote.create!(assessment: self, price: 0)
  end
end
