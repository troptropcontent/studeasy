# frozen_string_literal: true

# The solution holds the buddy that have been assigned to the quote
class SolutionsController < ApplicationController
  def create
    @assessment = Assessment.find(params[:assessment_id])
    @quote = @assessment.quote
    @assessment.quote.create_solution(user: current_user)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(helpers.dom_id(@assessment, :solution),
                                                  partial: 'assessments/buddy/show/quote_section/assigned')
      end
    end
  end

  def update
    @assessment = Assessment.find(params[:assessment_id])
    @solution = @assessment.solution
    return unless @solution.update(document_params) && @solution.documents.attached?

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def document_params
    params.require(:solution).permit(documents: [])
  end
end
