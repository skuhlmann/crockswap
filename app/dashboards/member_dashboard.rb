require "administrate/base_dashboard"

class MemberDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    group: Field::BelongsTo,
    id: Field::Number,
    status: Field::String,
    invite_token: Field::String,
    invite_sent_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :user,
    :group,
    :id,
    :status,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :user,
    :group,
    :id,
    :status,
    :invite_token,
    :invite_sent_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :user,
    :group,
    :status,
    :invite_token,
    :invite_sent_at,
  ].freeze

  # Overwrite this method to customize how members are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(member)
  #   "Member ##{member.id}"
  # end
end
