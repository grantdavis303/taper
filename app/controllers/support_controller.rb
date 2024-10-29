class SupportController < ApplicationController
  before_action :require_user

  def index; end

  private
  
  def require_user
    redirect_to root_path unless logged_in?
  end
end