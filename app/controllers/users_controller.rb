class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
    @cooking_levels = %w[1 2 3 4 5]
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to edit_profile_path(current_user), alert: 'Successfully updated.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :city, :zip_code, :cooking_level)
  end
end
