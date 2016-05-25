class User < ActiveRecord::Base
  has_many :members
  has_many :groups, through: :members

  has_and_belongs_to_many :diet_restrictions

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  def self.temporary(email)
    user = new(email: email, password: rand(36**8).to_s(36))
    user.skip_confirmation!
    user.save!
    user
  end
end