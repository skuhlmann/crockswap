class WeeksController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize_user_group(params[:group_name])
    @user = current_user
    @week = Week.new
    @is_admin = set_admin(@group)
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

    start = Date.parse(week_params[:start_date])
    number = params[:number_of_weeks].to_i
    location = week_params[:swap_location]
    if params[:add]
      swap = Date.parse(week_params[:swap_date]).wday
    else
      swap = day_map[week_params[:swap_date].downcase.to_sym]
    end

    weeks = ScheduleMaker.new(start, swap, location, number).create_weeks
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
    params.require(:week).permit(:start_date, :swap_date, :swap_location)
  end

  def start_date_param
    date = week_params[:start_date].split("-")
    "#{date[2]}-#{date[0]}-#{date[1]}"
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