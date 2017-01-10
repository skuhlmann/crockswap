require "administrate/base_dashboard"

class MealDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
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

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :user,
    :week,
    :category,
    :reviews,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :user,
    :week,
    :category,
    :reviews,
    :id,
    :name,
    :created_at,
    :updated_at,
    :meal_category_id,
    :recipe_url,
    :instructions,
    :accompaniments,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :user,
    :week,
    :category,
    :reviews,
    :name,
    :meal_category_id,
    :recipe_url,
    :instructions,
    :accompaniments,
  ].freeze

  # Overwrite this method to customize how meals are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(meal)
  #   "Meal ##{meal.id}"
  # end
end
