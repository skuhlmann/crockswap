class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  
  has_attached_file :picture, styles: { medium: "300", thumb: "100x100#" }
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  def has_picture?
    picture.url != "/pictures/original/missing.png"
  end
end