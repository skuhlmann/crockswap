class User < ActiveRecord::Base
  has_and_belongs_to_many :groups

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable
end