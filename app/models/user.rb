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

  def self.temporary(data)
    user = new(email: data[:email], name: data[:name], password: rand(36**10).to_s(36))
    user.skip_confirmation!
    user.save!
    user
  end

  def invite_status(group)
    Member.where(group_id: group.id, user_id: id).first.status
  end
end