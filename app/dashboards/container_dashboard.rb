require "administrate/base_dashboard"

class ContainerDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    groups: Field::HasOne,
    id: Field::Number,
    name: Field::String,
    size: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    active: Field::Boolean,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :groups,
    :id,
    :name,
    :size,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :groups,
    :id,
    :name,
    :size,
    :created_at,
    :updated_at,
    :active,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :groups,
    :name,
    :size,
    :active,
  ].freeze

  # Overwrite this method to customize how containers are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(container)
  #   "Container ##{container.id}"
  # end
end
