require 'rails_helper'

RSpec.describe "Assessments", type: :request do
  describe "GET /index" do
    context "when the user is authenticated" do
      it "can only access his contents" do
        sign_in user
      end
    end
  end
end
