class AdminSelector
  def initialize(assessments, user, tab)
    @assessments = assessments
    @user = user
    @tab = tab
  end

  def call
    send("#{@tab}_assessments".to_sym)
  end

  private

  def main_assessments
    @assessments.with_status
                .where(
                  statuses: {
                    assessment_status: %w[
                      waiting_for_quotation
                      waiting_for_payment
                      paid
                    ]
                  }
                )
  end

  def in_progress_assessments
    @assessments.with_status.where(statuses: { assessment_status: ['assigned'] })
  end

  def past_assessments
    @assessments.with_status.where(statuses: { assessment_status: ['done'] })
  end
end
