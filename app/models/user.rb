class User < ActiveRecord::Base
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "pizza.svg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  validates_presence_of :email

  has_many :members
  has_many :meals
  has_many :reviews
  has_many :groups, through: :members

  has_and_belongs_to_many :diet_restrictions

  before_create :normalize_email

  before_destroy :delete_associated_members

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  def self.temporary(data)
    new_user = {
      email: data[:email],
      name: data[:name],
      password: rand(36**10).to_s(36),
      temporary: true
    }
    user = new(new_user)
    user.skip_confirmation!
    user.save!
    user
  end

  def invite_status(group)
    Member.where(group_id: group.id, user_id: id).take.status
  end

  def week_meal(week)
    meals.where(week_id: week.id).take
  end

  def group_meals(group)
    week_ids = group.weeks.pluck(:id)
    meals.select do |meal|
      week_ids.any? { |week_id| meal.week_id == week_id }
    end
  end

  private

  def normalize_email
    self.email = self.email.downcase
  end

  def delete_associated_members
    members.destroy_all
  end
end