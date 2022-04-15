# frozen_string_literal: true

# This class is responsible of creating email object for Assessments
class AssessmentMailer < ApplicationMailer
  ADMIN_EMAIL = 'assessmentcopilot+admin@gmail.com'

  def new_assessment_email
    @assessment = params[:assessment]
    mail(to: ADMIN_EMAIL, subject: 'A new assessment have been uploaded')
  end
end
