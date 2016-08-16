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
    # binding.pry

    @group = Group.find(params[:group_name])
    @user = current_user
    @meal = Meal.create(meal_params)
    @meal.week_id = params[:week_id]
    @meal.user_id = @user.id
    if @meal.save!

      redirect_to group_path(@group), notice: "Success"
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  private

  def meal_params
    params.require(:meal).permit(:name)
  end
end