class Group < ActiveRecord::Base
  has_many :invites
  has_many :users, through: :invites

  has_and_belongs_to_many :diet_restrictions
  has_and_belongs_to_many :containers
end


