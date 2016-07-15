class WeeksController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize_user_group(params[:group_name])
  end

  def new
    authorize_admin(params[:group_name])
    @week = Week.new
    @days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
  end

  def create
    authorize_admin(params[:group_name])
    start = Date.parse(start_date_param)
    swap = week_params[:swap_date].downcase
    number = params[:number_of_weeks].to_i

    weeks = ScheduleMaker.new(start, swap, number).create_weeks
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
    params.require(:week).permit(:start_date, :swap_date)
  end

  def start_date_param
    date = week_params[:start_date].split("/")
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
end