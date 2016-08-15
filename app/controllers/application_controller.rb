class ApplicationController < ActionController::Base
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def set_admin(group)
    group.admin == current_user.id if group
  end
end
