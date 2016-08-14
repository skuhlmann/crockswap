class Week < ActiveRecord::Base
  belongs_to :groups
  has_many :meals
end
