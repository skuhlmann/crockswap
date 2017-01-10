require "administrate/base_dashboard"

class ReviewDashboard < Administrate::BaseDashboard
 
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    meal: Field::BelongsTo,
    id: Field::Number,
    rating: Field::Number,
    feedback: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :id,
    :user,
    :meal,
    :rating,
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :user,
    :meal,
    :id,
    :rating,
    :feedback,
    :created_at,
    :updated_at,
  ].freeze

  FORM_ATTRIBUTES = [
    :user,
    :meal,
    :rating,
    :feedback,
  ].freeze
end