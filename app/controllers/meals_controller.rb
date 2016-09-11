class MealsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_view_active

  def show
    authorize_meal_user
    @group = Group.where(name: params[:group_name]).first
    @week = Week.find(params[:week_id])
    @list_users = @group.users.reject { |user| user.id == current_user.id }
  end

  def new
    @group = Group.where(name: params[:group_name]).first
    @user = current_user
    @week = Week.find(params[:week_id])
    @meal = Meal.new
  end

  def create
    @group = Group.find(params[:group_name])
    @user = set_new_meal_user
    @meal = Meal.create(meal_params)
    @meal.week_id = params[:week_id]
    @meal.user_id = @user.id
    if @meal.save!
      redirect_to group_path(@group), notice: "Success"
    else
      render :new
    end
  end

  def update
    authorize_meal_user
    @group = Group.find(params[:group_name])
    if @meal.update(meal_params)
      redirect_to group_week_meal_path(@group.name, params[:week_id], @meal), notice: "Success"
    else
      render :edit
    end
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :recipe_url, :freezable, :covered, :time_to_eat, :cooking_degrees, :cooking_time, :meal_category_id)
  end

  def multi_meal_params
    params.select { |k, v| k.include?("user_") }
  end

  def set_new_meal_user
    params[:user_id] ? params[:user_id] : current_user
  end

  def authorize_meal_user
    @meal = Meal.find(params[:id])
    unless @meal.user_id == current_user.id
      redirect_to user_root_path
    end
  end

  def set_view_active
    @active_week_view_path = "weeks_active"
  end

end