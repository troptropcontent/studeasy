class BuddySelector
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
    @assessments.with_status.where(statuses: { assessment_status: ['paid'] })
  end

  def in_progress_assessments
    @assessments.with_status
                .joins(quote: :solution)
                .where(
                  statuses: {
                    assessment_status: [
                      'assigned'
                    ]
                  },
                  solution: { user_id: @user.id }
                )
  end

  def past_assessments
    @assessments.with_status
                .joins(quote: :solution)
                .where(
                  statuses: {
                    assessment_status: [
                      'done'
                    ]
                  },
                  solution: { user_id: @user.id }
                )
  end
end
