class AssessmentsController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource

    def index
        @assessment = Assessment.new
    end

    # POST /tweets
    def create
        respond_to do |format|
            if @assessment.save
                @new_assessment = Assessment.new
                format.turbo_stream 
            else
                format.turbo_stream { render turbo_stream: turbo_stream.replace(@assessment, partial: "assessments/shared/form", locals: { assessment: @assessment}) }
            end
        end
    end

    private

    def assessment_params
        params.require(:assessment).permit(:name, :deadline, documents: [])
    end

end
