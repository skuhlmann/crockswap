class GroupsController < ApplicationController
  before_action :authenticate_user!

  def new
    @group = Group.new
  end

  def create
    @group = Group.create(group_params)
    @group.users << current_user
    if @group.save
      redirect_to user_root_path, notice: "Success"
    else
      render :new
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :budget, :max_participants)
  end
end