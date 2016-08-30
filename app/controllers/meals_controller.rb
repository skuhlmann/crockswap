class MealsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
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

  def create_multiple
    @group = Group.where(name: params[:group_name]).first
    @week = Week.find(params[:week_id])
    multi_meal_params.each_pair do |k, new_meal|
      new_data = { name: new_meal[:name] }
      meal = Meal.where(user_id: new_meal[:user_id], week_id: @week.id).first
      if meal
        meal.update(new_data)
      else
        new_data[:user_id] = new_meal[:user_id]
        new_data[:week_id] = @week.id
        Meal.create(new_data)
      end
    end
    redirect_to group_week_path(@group.name, @week), alert: 'Successfully updated.'
  end

  def edit
  end

  def update
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
end