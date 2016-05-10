class Group < ActiveRecord::Base
  has_many :invites
  has_many :users, through: :invites

  has_and_belongs_to_many :diet_restrictions
  belongs_to :container

  validates :name, uniqueness: true
  validates :name, presence: true
  validates :max_participants, numericality: { greater_than: 0 }
end


