namespace "tool" do
  task :kill_rates => :environment do
    users = User.all
    users.each do |user| 
      user_rates = Rate.where(rater_id: user.id)
      self_rated = user_rates.inject([]) do |self_rates, rate|
        self_rates << rate if user.meals.any? { |meal| meal.id == rate.rateable_id } 
        self_rates
      end

      self_rated.each { |rate| rate.destroy }
    end
  end
end