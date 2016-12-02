class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :meal

  def rating_text
    case rating
    when 1
      "Retire it"
    when 2
      "Make it again, with changes"
    when 3
      "Make it again"
    else
      ""
    end
  end
end