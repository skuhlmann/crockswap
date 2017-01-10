class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def set_admin(group)
    group.admin == current_user.id if group
  end
end
