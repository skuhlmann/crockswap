class DietRestriction < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :groups

  validates :name, presence: true
  validates :name, uniqueness: true
end