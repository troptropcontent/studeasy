class UserEmailAuthorisationsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_authorisations
  load_and_authorize_resource
  def index
    @user_email_authorisations
  end

  def create
    redirect_to assessments_path(tab: 'settings') if @user_email_authorisation.save
  end

  def destroy
    @user_email_authorisation.destroy

    render 'index'
  end

  private

  def user_email_authorisation_params
    params.require(:user_email_authorisation).permit(:email, :role)
  end

  def load_authorisations
    @user_email_authorisations = UserEmailAuthorisation.buddy
  end
end
