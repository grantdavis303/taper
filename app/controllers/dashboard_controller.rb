class DashboardController < ApplicationController
  before_action :require_user

  def index
    redirect_to root_path if current_user.nil?
  end

  private def require_user
    redirect_to root_path unless logged_in?
    # render file: "public/404.html" unless logged_in?
  end
end