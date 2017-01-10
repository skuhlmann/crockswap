require "administrate/base_dashboard"

class MealDashboard < Administrate::BaseDashboard
 
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    week: Field::BelongsTo,
    category: Field::BelongsTo.with_options(class_name: "MealCategory"),
    reviews: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    meal_category_id: Field::Number,
    recipe_url: Field::String,
    instructions: Field::String,
    accompaniments: Field::String,
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :id,
    :user,
    :week,
    :category,
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :user,
    :week,
    :category,
    :id,
    :name,
    :created_at,
    :updated_at,
    :meal_category_id,
    :recipe_url,
    :instructions,
    :accompaniments,
    :reviews,
  ].freeze

  FORM_ATTRIBUTES = [
    :user,
    :week,
    :name,
    :meal_category_id,
    :recipe_url,
    :instructions,
    :accompaniments,
  ].freeze
  
  def display_resource(meal)
    "Meal: #{meal.name}"
  end
end
