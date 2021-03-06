class MealMailer < ActionMailer::Base
  default from: 'fromcrockswap@gmail.com'

  def rating_email(meal, review)
    @review = review
    @meal = meal
    @user = User.find(meal.user_id)
    @group = @meal.week.group
    @member = Member.where(group_id: @group.id, user_id: @user.id).take
    
    mail(to: @user.email,
    subject: "Your #{@meal.name} was rated on Crockswap!")
  end
  
  def meal_added_email(user, meal, group)
    @user = user
    @group = group
    @meal = meal
    @member = Member.where(group_id: @group.id, user_id: @user.id).take

    mail(to: @user.email,
         subject: "A meal was added to #{@group.name} on Crockswap!")
  end
end