class SolutionsController < ApplicationController
  def create
    assessment = Assessment.find(params[:assessment_id])
    assessment.quote.create_solution(user: current_user)
  end

  def update
    assessment = Assessment.find(params[:assessment_id])
    solution = assessment.solution
    respond_to do |_format|
      if solution.update(solution_params)
        respond_to do |format|
          format.html { redirect_to @session.url, allow_other_host: true }
        end
      end
    end
  end

  private

  def solution_params
    params.require(:solution).permit(:documents)
  end
end
