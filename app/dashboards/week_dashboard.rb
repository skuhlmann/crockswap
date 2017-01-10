require "administrate/base_dashboard"

class WeekDashboard < Administrate::BaseDashboard
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

  COLLECTION_ATTRIBUTES = [
    :id,
    :group,
    :meals,
    :swap_date,
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :group,
    :id,
    :swap_date,
    :start_date,
    :swap_location,
    :created_at,
    :updated_at,
    :paused,
    :swap_time,
    :meals,
  ].freeze

  FORM_ATTRIBUTES = [
    :group,
    :swap_date,
    :start_date,
    :swap_location,
    :paused,
    :swap_time,
  ].freeze
end