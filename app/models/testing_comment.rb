class TestingComment < ActiveRecord::Base
  validates :comments, presence: true
end
