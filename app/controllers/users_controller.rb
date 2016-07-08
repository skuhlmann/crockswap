class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:temporary, :temporary_update]
  layout "simple", only: [:temporary]

  def edit
    @user = current_user
    @diet_restrictions = DietRestriction.all
  end

  def update
    @user = current_user
    @user.diet_restriction_ids = diet_params

    if @user.update(user_params)
      redirect_to edit_profile_path(@user), alert: 'Successfully updated.'
    else
      render :edit
    end
  end

  def temporary
    @user = User.find(params[:id])
    @diet_restrictions = DietRestriction.all
  end

  def temporary_update
    @user = User.find(user_params[:id])
    update_params = user_params
    update_params["temporary"] = false

    if confirm_password
      @user.update(update_params)
      sign_in @user, :bypass => true
      redirect_to user_root_path(@user), notice: "Success!"
    else
      flash[:alert] = "Password and matching confirmation are required"
      redirect_to complete_profile_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :city, :zip_code, :cooking_level,
      :diet_restrictions, :temporary, :id, :password, :password_confirmation)
  end

  def diet_params
    params[:user][:diet_restriction_ids].reject { |diet| diet.empty? }
  end

  def confirm_password
    user_params[:password]!= "" && user_params[:password] == user_params[:password_confirmation]
  end
end
