# frozen_string_literal: true

# This class receive all the request ending on the /assessments endpoint
class AssessmentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  layout :find_layout

  # simple PORO object that returns 'assessments/no_assessment' when receive #to_partial_path
  class NoAssessmentObject
    def to_partial_path
      'assessments/no_assessment'
    end
  end

  # GET /assessments
  def index
    @assessment = Assessment.new
    @tab = tab_params || 'main'
    @assessments = determine_assessments

    respond_to do |format|
      format.html { render "assessments/#{current_user.role}_index" }
    end
  end

  # GET /assessments/:id
  def show
    @quote = @assessment.quote
    @view = current_user.role
    render variants: current_user.role.to_sym
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
    @assessments = current_user.assessments
    @assessment.quote
    @tab = 'main'
    AssessmentMailer.with(assessment: @assessment).new_assessment_email.deliver_later
    format.html { render "assessments/#{current_user.role}_index" }
    format.turbo_stream { redirect_to root_path }
  end

  def handle_invalid_assessment_creation(format)
    format.turbo_stream do
      render turbo_stream: turbo_stream.replace(@assessment, partial: 'assessments/shared/form',
                                                             locals: { assessment: @assessment })
    end
  end

  def no_assessments_object
    @no_assessments_object ||= NoAssessmentObject.new
  end

  def tab_params
    params.permit(:tab)[:tab]
  end

  def find_layout
    "application_#{current_user.role}"
  end

  def determine_assessments
    return no_assessments_object if @assessments.empty?
    return @assessments if current_user.student?

    AssessmentsSelector.new(@assessments, current_user, @tab).call
  end
end
