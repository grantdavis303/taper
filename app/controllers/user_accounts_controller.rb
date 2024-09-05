class UserAccountsController < ApplicationController
  def new; end

  def create
    new_user = User.new(user_params)
    if new_user.valid?
      new_user.save!
      if params[:password] == params[:password_confirmation]
        new_account = Account.new(
          user_id: new_user.id,
          role_id: 1,
          username: params[:username],
          password: params[:password]
        )
        if new_account.valid?
          new_account.save!
          flash[:success] = 'Account created successfully.'
          redirect_to root_path
        else
          new_user.destroy!
          flash[:error] = new_account.errors.full_messages.to_sentence + '.'
          redirect_to new_user_account_path
        end
      else
        flash[:error] = 'These passwords do not match.'
        redirect_to new_user_account_path
      end
    else
      flash[:error] = new_user.errors.full_messages.to_sentence + '.'
      redirect_to new_user_account_path
    end
  end

  private

  def user_params
    params
      .permit(:first_name, :last_name, :email, :phone_number)
  end
end