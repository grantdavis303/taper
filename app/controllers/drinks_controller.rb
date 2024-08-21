class DrinksController < ApplicationController
  before_action :require_user

  def index; end

  def new; end

  def create
    new_drink = current_user.drinks.new(drink_params)
    if new_drink.valid?
      new_drink.save!
      flash[:success] = 'Drink added successfully'
      redirect_to dashboard_index_path
    else
      flash[:error] = new_drink.errors.full_messages.to_sentence + '.'
      redirect_to new_drink_path
    end
  end

  def destroy
    deleted_drink = Drink.find(params[:id])
    deleted_drink.destroy
    flash[:success] = 'Drink deleted successfully'
    redirect_to drinks_path
  end

  private

  def drink_params
    params
      .permit(:drink_type, :ounces, :percentage)
  end

  def require_user
    redirect_to root_path unless logged_in?
  end
end