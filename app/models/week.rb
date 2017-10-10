class Week < ActiveRecord::Base
  belongs_to :group
  has_many :meals

  def is_past?
    Date.today > (start_date)
  end
end
