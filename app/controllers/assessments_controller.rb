# frozen_string_literal: true

# This class receive all the request ending on the /assessments endpoint
class AssessmentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /assessments
  def index
    @assessment = Assessment.new

    render "assessments/#{current_user.role}_index"
  end

  # GET /assessments/:id
  def show
    @quote = @assessment.quote
    @admin_view = current_user.admin?
  end

  # POST /assessments
  def create
    respond_to do |format|
      if @assessment.save
        handle_assessment_creation(format)
      else
        handle_invalid_assessment_creation(format)
      end
    end
  end

  # DELETE /tweets/:id
  def destroy
    @assessment.destroy

    @assessments_count = current_user.assessments.count
    puts @assessments_count
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def assessment_params
    params.require(:assessment).permit(:name, :deadline, :description, documents: [])
  end

  def handle_assessment_creation(format)
    AssessmentMailer.with(assessment: @assessment).new_assessment_email.deliver_later
    @new_assessment = Assessment.new
    format.turbo_stream
  end

  def handle_invalid_assessment_creation(format)
    format.turbo_stream do
      render turbo_stream: turbo_stream.replace(@assessment, partial: 'assessments/shared/form',
                                                             locals: { assessment: @assessment })
    end
  end
end
