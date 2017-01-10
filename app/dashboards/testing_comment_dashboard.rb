require "administrate/base_dashboard"

class TestingCommentDashboard < Administrate::BaseDashboard

  ATTRIBUTE_TYPES = {
    id: Field::Number,
    name: Field::String,
    email: Field::String,
    comments: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :id,
    :name,
    :email,
    :comments,
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :name,
    :email,
    :comments,
    :created_at,
    :updated_at,
  ].freeze

  FORM_ATTRIBUTES = [
    :name,
    :email,
    :comments,
  ].freeze
end