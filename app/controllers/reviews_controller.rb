class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    authorize_user_group
    review = Review.new(review_params)
    review.user_id = current_user.id
    review.meal_id = params[:meal_id]

    if review.save!
      meal = Meal.find(review.meal_id)
      send_rating_email(meal, review)
    end
    
    session[:return_to] ||= request.referer
    redirect_to session.delete(:return_to), notice: "Thanks for the feedback!"
  end
  
  def update
    authorize_user_group
    @review = Review.find(params[:id])
    @review.update(review_params)
    
    session[:return_to] ||= request.referer
    redirect_to session.delete(:return_to), notice: "You review was updated"
  end
  
  private
  
  def review_params
    params.require(:review).permit(:feedback, :rating)
  end
  
  def authorize_user_group
    meal = Meal.find(params[:meal_id])
    meal.week.group.users.include?(current_user)
  end
  
  def send_rating_email(meal, review)
    member = Member.where(group_id: meal.week.group_id, user_id: meal.user_id).take
    if member.email_opt
      MealMailer.rating_email(meal, review).deliver_now
    end
  end
end
