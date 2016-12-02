class Group < ActiveRecord::Base
  has_many :members
  has_many :users, through: :members

  has_and_belongs_to_many :diet_restrictions
  belongs_to :container
  has_many :weeks

  validates :name, uniqueness: true
  validates :name, presence: true
  validates :max_participants, numericality: { greater_than: 0 }

  before_destroy :clean_up_members

  def current_week
    today = Date.today
    weeks.find do |week|
      today >= week.start_date && today <= (week.start_date + 7)
    end
  end

  def next_week
    next_week = Date.today + 7
    weeks.find do |week|
      next_week >= (week.start_date) && next_week <= (week.start_date + 7)
    end
  end

  def last_week
    next_week = Date.today - 7
    weeks.find do |week|
      next_week >= (week.start_date) && next_week <= (week.start_date + 7)
    end
  end

  def active_users
    users.where(temporary: false)
  end

  def leaderboard_users
    users.where(temporary: false)
      .sort_by { |user| user.average_rating(self) }.reverse
  end


  def clean_up_members
    members.destroy_all
  end
end


