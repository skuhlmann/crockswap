class User < ActiveRecord::Base
  ratyrate_rater

  # has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.svg"
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "pizza.svg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_many :members
  has_many :meals
  has_many :groups, through: :members

  has_and_belongs_to_many :diet_restrictions

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
    Member.where(group_id: group.id, user_id: id).first.status
  end

  def week_meal(week)
    meals.find { |meal| meal.week_id == week.id }
  end

  def group_meals(group)
    week_ids = group.weeks.pluck(:id)
    meals.select do |meal|
      week_ids.any? { |week_id| meal.week_id == week_id }
    end
  end

  def average_rating(group)
    group_meals(group).inject(0) do |sum, meal|
      meal_avg = meal.rating_average
      unless meal_avg.nil?
        sum += meal_avg.avg
      end
      sum
    end
  end

  def average_overall_rating
    meals.inject(0) do |sum, meal|
      meal_avg = meal.rating_average
      unless meal_avg.nil?
        sum += meal_avg.avg
      end
      sum
    end
  end

  private

  def delete_associated_members
    members.destroy_all
  end
end