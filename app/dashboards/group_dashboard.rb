require "administrate/base_dashboard"

class GroupDashboard < Administrate::BaseDashboard

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

  COLLECTION_ATTRIBUTES = [
    :id,
    :name,
    :users,
    :admin,
    :created_at,
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :name,
    :max_participants,
    :budget,
    :container_type,
    :created_at,
    :updated_at,
    :admin,
    :leaderboard,
    :members,
    :users,
    :container,
    :weeks,
  ].freeze

  FORM_ATTRIBUTES = [
    :name,
    :container,
    :max_participants,
    :budget,
    :container_type,
    :admin,
    :leaderboard,
  ].freeze


  def display_resource(group)
    "Group: #{group.name}"
  end
end
