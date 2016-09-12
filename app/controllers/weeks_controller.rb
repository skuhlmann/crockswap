class WeeksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_view_active

  def index
    authorize_user_group(params[:group_name])
    has_weeks?

    @user = current_user
    @week = Week.new
    @is_admin = set_admin(@group)
    @weeks = sort_weeks
    @this_week_index = find_week_index
  end

  def show
    authorize_user_group(params[:group_name])
    @week = Week.find(params[:id])
    @is_admin = set_admin(@group)
    @user_meal = current_user.week_meal(@week)
    @list_users = @group.users.reject { |user| user.id == current_user.id }
  end

  def update
    authorize_admin(params[:group_name])
    @week = Week.find(params[:id])

    if @week.update(week_params)
      redirect_to group_week_path(@group.name, @week), alert: 'Successfully updated.'
    else
      render :edit
    end
  end

  def new
    authorize_admin(params[:group_name])
    @week = Week.new
    @days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
  end

  def create
    authorize_admin(params[:group_name])

    number = params[:number_of_weeks].to_i

    if params[:add]
      start = @group.weeks.last.start_date + 7
      default_values = {
        swap: Date.parse(week_params[:swap_date]).wday,
        location: @group.weeks.last.swap_location,
        time: @group.weeks.last.swap_time
      }
    else
      start = Date.parse(week_params[:start_date])
      default_values = {
        location: week_params[:swap_location],
        time: week_params[:swap_time],
        swap: day_map[week_params[:swap_date].downcase.to_sym]
      }
    end

    weeks = ScheduleMaker.new(start, default_values, number).create_weeks
    Week.transaction do
      weeks.each do |week|
        week.group_id = @group.id
        week.save!
      end
    end

    redirect_to group_weeks_path(@group.name)
  end

  private

  def week_params
    params.require(:week).permit(:start_date, :swap_date, :swap_location, :paused, :swap_time)
  end

  def start_date_param
    date = week_params[:start_date].split("-")
    "#{date[2]}-#{date[0]}-#{date[1]}"
  end

  def sort_weeks
    @group.weeks.sort_by { |week| week.start_date }
  end

  def find_week_index
    @weeks.find_index(@group.current_week)
  end

  def authorize_user_group(group_name)
    if current_user.groups.pluck(:name).any? { |name| name == group_name }
      @group = Group.where(name: group_name).first
    else
      redirect_to user_root_path
    end
  end

  def has_weeks?
    if @group.weeks.count == 0
      redirect_to new_group_week_path(@group.name)
    end
  end

  def authorize_admin(group_name)
    @group = Group.where(name: group_name).first
    unless @group.admin == current_user.id
      redirect_to group_path(@group.name)
    end
  end

  def set_view_active
    @active_week_view_path = "weeks_active"
  end

  def day_map
    {
      sunday: 0,
      monday: 1,
      tuesday: 2,
      wednesday: 3,
      thursday: 4,
      friday: 5,
      saturday: 6
    }
  end
end