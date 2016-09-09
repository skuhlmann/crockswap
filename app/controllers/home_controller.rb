class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    #temp prod view
    render 'temp_index', layout: "simple"
  end

  def swapboard
    @user = current_user
    @groups = @user.groups
    if params[:group_name]
      @group = @groups.select { |group| group.name == params[:group_name] }[0]
      @is_admin = set_admin(@group)
    else
      if @groups.count > 1
        redirect_to groups_path
      end
      @group = @groups.first
      @is_admin = set_admin(@group)
    end
  end
end
