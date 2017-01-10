require "administrate/base_dashboard"

class MealCategoryDashboard < Administrate::BaseDashboard

  ATTRIBUTE_TYPES = {
    meals: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :id,
    :name,
    :meals,
    :created_at,
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :name,
    :created_at,
    :updated_at,
    :meals,
  ].freeze

  FORM_ATTRIBUTES = [
    :meals,
    :name,
  ].freeze

  def display_resource(meal_category)
    "MealCategory: #{meal_category.name}"
  end
end
