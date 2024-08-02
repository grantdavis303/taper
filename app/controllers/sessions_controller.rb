class SessionsController < ApplicationController
  def new
    redirect_to dashboard_index_path if session.include?(:remember_me)
  end

  def create
    if Account.find_by(username: params[:username])
      account = Account.find_by(username: params[:username])
      if account.authenticate(params[:password])
        session[:remember_me] = true if params.include?(:remember_me)
        session[:user_id] = account.id
        flash[:success] = 'Successfully logged in.'
        redirect_to dashboard_index_path
      else
        flash[:error] = 'Bad credentials. Please try again.'
        redirect_to root_path
      end
    else
      flash[:error] = 'User not found.'
      redirect_to root_path
    end
  end

  def destroy
    reset_session
    flash[:success] = 'Successfully logged out.'
    redirect_to root_path
  end
end