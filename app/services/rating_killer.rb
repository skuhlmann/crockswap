class RatingKiller
  def self.perform
    @users = User.all
    @users.each do { |user| clean_ratings(user) }
  end

  def self.clean_ratings(user)
    user_rates = Rate.where(rater_id: user.id)

    self_rated = user_rates.inject([]) do |self_rates, rate|
      rate if user.meals.any? { |meal| meal.id == rate.rateable_id } 
    end
  end
end