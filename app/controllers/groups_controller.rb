class GroupsController < ApplicationController
  before_action :authenticate_user!

  def show
    authorize_user_group
  end

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

  def edit
    authorize_user_group
    @diet_restrictions = DietRestriction.all
    @containers = Container.all.collect { |c| ["#{c.name} - #{c.size}", c.id] }
  end

  def update
    authorize_user_group
    @group.diet_restriction_ids = diet_params
    # @group.container_id = group_params[:container]

    if @group.update(group_params)
      redirect_to group_path(@group.name), alert: 'Successfully updated.'
    else
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :budget, :max_participants, :swap_location, :container_id)
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
end