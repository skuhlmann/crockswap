require "administrate/base_dashboard"

class ContainerDashboard < Administrate::BaseDashboard

  ATTRIBUTE_TYPES = {
    groups: Field::HasOne,
    id: Field::Number,
    name: Field::String,
    size: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    active: Field::Boolean,
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :id,
    :name,
    :size,
    :groups,
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :name,
    :size,
    :created_at,
    :updated_at,
    :active,
    :groups,
  ].freeze

  FORM_ATTRIBUTES = [
    :name,
    :size,
    :active,
    :groups,
  ].freeze
end