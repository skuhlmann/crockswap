require "administrate/base_dashboard"

class MemberDashboard < Administrate::BaseDashboard

  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    group: Field::BelongsTo,
    id: Field::Number,
    status: Field::String,
    invite_token: Field::String,
    invite_sent_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :id,
    :user,
    :group,
    :status,
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :user,
    :group,
    :id,
    :status,
    :invite_token,
    :invite_sent_at,
  ].freeze

  FORM_ATTRIBUTES = [
    :user,
    :group,
    :status,
    :invite_token,
    :invite_sent_at,
  ].freeze
end