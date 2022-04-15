# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/assessment
class AssessmentPreview < ActionMailer::Preview
  def new_assessment_email
    AssessmentMailer.with(assessment: Assessment.first).new_assessment_email
  end
end
