class Meal < ActiveRecord::Base
  has_attached_file :picture, styles: { medium: "300", thumb: "100x100#" }, default_url: "pizza.svg"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  belongs_to :user
  belongs_to :week
  belongs_to :category, class_name: MealCategory, foreign_key: "meal_category_id"
  has_many :reviews

  before_save :parse_url

  def parse_url
    if self.recipe_url && !self.recipe_url.include?("http")
      self.recipe_url = "http://#{recipe_url}"
    end
  end

  def review_by_user(user)
    self.reviews.where(user_id: user.id).take
  end
end