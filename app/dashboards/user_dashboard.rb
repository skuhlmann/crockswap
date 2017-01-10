require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard

  ATTRIBUTE_TYPES = {
    id: Field::Number,
    email: Field::String,
    encrypted_password: Field::String,
    reset_password_token: Field::String,
    reset_password_sent_at: Field::DateTime,
    remember_created_at: Field::DateTime,
    sign_in_count: Field::Number,
    current_sign_in_at: Field::DateTime,
    last_sign_in_at: Field::DateTime,
    current_sign_in_ip: Field::String.with_options(searchable: false),
    last_sign_in_ip: Field::String.with_options(searchable: false),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    confirmation_token: Field::String,
    confirmed_at: Field::DateTime,
    confirmation_sent_at: Field::DateTime,
    cooking_level: Field::Number,
    name: Field::String,
    zip_code: Field::Number,
    city: Field::String,
    temporary: Field::Boolean,
    super_admin: Field::Boolean,
    description: Field::String,
    avatar_file_name: Field::String,
    avatar_content_type: Field::String,
    avatar_file_size: Field::Number,
    avatar_updated_at: Field::DateTime,
    members: Field::HasMany,
    meals: Field::HasMany,
    reviews: Field::HasMany,
    groups: Field::HasMany,
    diet_restrictions: Field::HasMany,
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :id,
    :email,
    :name,
    :last_sign_in_at,
    :groups,
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :email,
    :super_admin,
    :encrypted_password,
    :reset_password_token,
    :reset_password_sent_at,
    :remember_created_at,
    :sign_in_count,
    :current_sign_in_at,
    :last_sign_in_at,
    :current_sign_in_ip,
    :last_sign_in_ip,
    :created_at,
    :updated_at,
    :confirmation_token,
    :confirmed_at,
    :confirmation_sent_at,
    :cooking_level,
    :name,
    :zip_code,
    :city,
    :temporary,
    :description,
    :avatar_file_name,
    :avatar_content_type,
    :avatar_file_size,
    :avatar_updated_at,
    :members,
    :meals,
    :reviews,
    :groups,
  ].freeze

  FORM_ATTRIBUTES = [
    :super_admin,
    :email,
    :cooking_level,
    :name,
    :zip_code,
    :city,
    :temporary,
    :description,
    :members,
    :meals,
    :reviews,
    :groups,
  ].freeze

  def display_resource(user)
    "User: #{user.email}"
  end
end
