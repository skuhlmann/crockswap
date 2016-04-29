class User < ActiveRecord::Base
  has_many :invites
  has_many :groups, through: :invites

  has_and_belongs_to_many :diet_restrictions
  has_and_belongs_to_many :containers

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

end