require "administrate/base_dashboard"

class GroupDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    members: Field::HasMany,
    users: Field::HasMany,
    diet_restrictions: Field::HasMany,
    container: Field::BelongsTo,
    weeks: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    max_participants: Field::Number,
    budget: Field::String.with_options(searchable: false),
    container_type: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    admin: Field::Number,
    leaderboard: Field::Boolean,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :members,
    :users,
    :diet_restrictions,
    :container,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :members,
    :users,
    :diet_restrictions,
    :container,
    :weeks,
    :id,
    :name,
    :max_participants,
    :budget,
    :container_type,
    :created_at,
    :updated_at,
    :admin,
    :leaderboard,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :members,
    :users,
    :diet_restrictions,
    :container,
    :weeks,
    :name,
    :max_participants,
    :budget,
    :container_type,
    :admin,
    :leaderboard,
  ].freeze

  # Overwrite this method to customize how groups are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(group)
  #   "Group ##{group.id}"
  # end
end
