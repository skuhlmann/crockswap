class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  
  has_attached_file :picture, styles: { medium: "300", thumb: "100x100#" }

  validates :body, presence: true
end