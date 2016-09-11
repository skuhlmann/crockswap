class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_view_active

  def index
    @user = current_user
    @groups = @user.groups
  end

  def show
    authorize_user_group(params[:name])
    @containers = Container.active.collect { |c| ["#{c.name} - #{c.size}", c.id] }
  end

  def new
    @group = Group.new
    @containers = Container.active.collect { |c| ["#{c.name} - #{c.size}", c.id] }
  end

  def create
    @group = Group.create(group_params)
    @group.users << current_user
    @group.admin = current_user.id
    if @group.save!
      redirect_to group_swapboard_path(@group.name), notice: "Success"
    else
      render :new
    end
  end

  def update
    authorize_admin(params[:name])

    if @group.update(group_params)
      redirect_to group_path(@group.name), alert: 'Successfully updated.'
    else
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :budget, :max_participants, :container_id)
  end

  def diet_params
    params[:group][:diet_restriction_ids].reject { |diet| diet.empty? }
  end

  def authorize_user_group(group_name)
    if current_user.groups.pluck(:name).any? { |name| name == group_name }
      @group = Group.where(name: group_name).first
    else
      redirect_to user_root_path
    end
  end

  def authorize_admin(group_name)
    @group = Group.where(name: group_name).first
    unless @group.admin == current_user.id
      redirect_to group_path(@group.name)
    end
  end

  def set_view_active
    @active_group_view_path = "group_active"
  end
end