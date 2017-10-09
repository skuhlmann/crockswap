class MealsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_view_active

  def show
    @meal = Meal.find(params[:id])
    @group = Group.where(name: params[:group_name]).first
    @week = Week.find(params[:week_id])
    @meal_categories = @week.available_categories.push(@meal.category)
    @list_users = @group.users.reject { |user| user.id == current_user.id }
    @is_meal_owner = is_meal_owner?(@meal)
    set_review if !@is_meal_owner
  end

  def new
    @group = Group.where(name: params[:group_name]).first
    @user = current_user
    @week = Week.find(params[:week_id])
    @meal = Meal.new
  end

  def create
    @group = Group.find(params[:group_name])
    if invalid_input?
      return redirect_to new_group_week_meal_path(@group.name, params[:week_id]), alert: "Please select a category and add your meal name!"
    end

    @user = set_new_meal_user
    @meal = Meal.create(meal_params)
    @meal.week_id = params[:week_id]
    @meal.user_id = @user.id
    if @meal.save!
      redirect_to group_week_meal_path(@group.name, params[:week_id], @meal), notice: "That sounds tasty!"
    else
      render :new
    end
  end

  def update
    authorize_meal_user
    @group = Group.find(params[:group_name])
    if @meal.update(meal_params)
      redirect_to group_week_meal_path(@group.name, params[:week_id], @meal), notice: "Updated. Still sounds tasty!"
    else
      render :edit
    end
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :recipe_url, :instructions, :meal_category_id, :accompaniments, :picture)
  end

  def multi_meal_params
    params.select { |k, v| k.include?("user_") }
  end

  def set_new_meal_user
    params[:user_id] ? params[:user_id] : current_user
  end

  def authorize_meal_user
    @meal = Meal.find(params[:id])
    unless is_meal_owner?(@meal)
      redirect_to user_root_path
    end
  end

  def is_meal_owner?(meal)
    meal.user_id == current_user.id
  end

  def invalid_input?
    meal_params[:name].empty? || meal_params[:meal_category_id].empty?
  end

  def set_view_active
    @active_week_view_path = "weeks_active"
  end

  def set_review
    @review = @meal.review_by_user(current_user)
    if @review.nil?
      @review = Review.new
    end
  end
end