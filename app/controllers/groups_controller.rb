class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_view_active
  before_action :authorize_user_group, only: [:show]
  helper_method :has_weeks?

  def index
    @user = current_user
    @groups = @user.groups
  end

  def show
    @containers = Container.active.collect { |c| ["#{c.name} - #{c.size}", c.id] }
    @week = Week.new
    @is_admin = set_admin(@group)
    @weeks = sort_weeks
    @this_week_index = find_week_index
  end

  def new
    @group = Group.new
    @containers = Container.active.collect { |c| ["#{c.name} - #{c.size}", c.id] }
  end

  def create
    @group = Group.create(group_params)
    @group.users << current_user
    @group.admin = current_user.id
    if @group.save
      redirect_to group_swapboard_path(@group.name), notice: "Success"
    else
      redirect_to new_group_path, alert: "Your group needs a name!"
    end
  end

  def update
    authorize_admin(params[:name])

    if @group.update(group_params)
      redirect_to group_path(@group.name), notice: 'Successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize_admin(params[:name])
    @group.destroy
    redirect_to user_root_path, notice: 'Group deleted.'
  end

  private

  def group_params
    params.require(:group).permit(:name, :budget, :max_participants, :container_id, :leaderboard)
  end

  def diet_params
    params[:group][:diet_restriction_ids].reject { |diet| diet.empty? }
  end

  def authorize_user_group
    if current_user.groups.pluck(:name).any? { |name| name == params[:name] }
      @group = Group.where(name: params[:name]).first
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

  def sort_weeks
    @group.weeks.sort_by { |week| week.start_date }
  end

  def find_week_index
    @weeks.find_index(@group.current_week)
  end

  def has_weeks?
    @group.weeks.count > 0
  end
end