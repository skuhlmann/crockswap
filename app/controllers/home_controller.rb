class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
  end

  def dashboard
    @user = current_user
    @groups = @user.groups
  end
end
