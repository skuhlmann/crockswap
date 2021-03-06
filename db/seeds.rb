class Seeds
  def self.seed_content
    Container.delete_all
    Container.create(name: "Pyrex", size: "11 cup rectangle")
    Container.create(name: "Pyrex", size: "6 cup rectangle")

    DietRestriction.delete_all
    DietRestriction.create(name: "Gluten-free")
    DietRestriction.create(name: "Vegetarian")
    DietRestriction.create(name: "Vegan")
    DietRestriction.create(name: "Paleo")
    DietRestriction.create(name: "Dairy-free")

    MealCategory.delete_all
    MealCategory.create(name: "Vegetarian")
    MealCategory.create(name: "Chicken")
    MealCategory.create(name: "Beef")
    MealCategory.create(name: "Pork")
    MealCategory.create(name: "Fish")
    MealCategory.create(name: "Wildcard")
  end

  def self.clear_user_groups
    Member.destroy_all
    Meal.destroy_all
    Week.destroy_all
    Group.destroy_all
    User.destroy_all
  end
end

Seeds.clear_user_groups
Seeds.seed_content