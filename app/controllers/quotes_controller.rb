# frozen_string_literal: true

# This is where all the queries regarding quote ressources will end
class QuotesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :assessment, id_param: :assessment_id
  load_and_authorize_resource :quote, through: :assessment, singleton: true

  # POST /assessments/:assessment_id/quote
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(helpers.dom_id(@assessment, :quote), partial: @quote,
                                                                                         locals: { quote: @quote })
        end
      end
    end
  end

  private

  def quote_params
    params.require(:quote).permit(:price)
  end
end
