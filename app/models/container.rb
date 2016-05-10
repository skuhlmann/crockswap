class Container < ActiveRecord::Base
  has_one :groups

  validates :name, presence: true

  def self.active
    where(active: true)
  end
end
