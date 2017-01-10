require "administrate/base_dashboard"

class WeekDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    group: Field::BelongsTo,
    meals: Field::HasMany,
    id: Field::Number,
    swap_date: Field::DateTime,
    start_date: Field::DateTime,
    swap_location: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    paused: Field::Boolean,
    swap_time: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :group,
    :meals,
    :id,
    :swap_date,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :group,
    :meals,
    :id,
    :swap_date,
    :start_date,
    :swap_location,
    :created_at,
    :updated_at,
    :paused,
    :swap_time,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :group,
    :meals,
    :swap_date,
    :start_date,
    :swap_location,
    :paused,
    :swap_time,
  ].freeze

  # Overwrite this method to customize how weeks are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(week)
  #   "Week ##{week.id}"
  # end
end
