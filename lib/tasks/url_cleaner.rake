namespace "tool" do
  task :clean_urls => :environment do
    meals = Meal.all
    meals.each do |meal| 
      if meal.recipe_url && !meal.recipe_url.include?("http")
        meal.recipe_url = "http://#{meal.recipe_url}"
        meal.save
      end
    end
  end
end