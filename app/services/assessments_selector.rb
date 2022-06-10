class AssessmentsSelector
  def initialize(assessments, user, tab)
    @assessments = assessments
    @user = user
    @tab = tab
  end

  def call
    selector.new(@assessments, @user, @tab).call
  end

  private

  def selector
    @selector ||= "#{@user.role.capitalize}Selector".constantize
  end
end
