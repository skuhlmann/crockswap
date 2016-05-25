class MembersController < GroupsController
  before_action :authenticate_user!

  def index
    authorize_user_group(params[:group_name])
    @members = @group.users
    @member = Member.new
  end

  def new
    authorize_user_group(params[:group_name])
    @member = Member.new
  end

  def create
    authorize_user_group(params[:group_name])
    user = User.where(email: member_params[:user])

    if user.empty?
      user = User.temporary(member_params[:user])
    elsif user_in_group?
      flash[:error] = "User is already in this group"
      render :index
    end

    if Member.invite(user, @group)
      redirect_to group_members_path(@group.name), alert: "An invite email has been sent."
    else
      flash[:error] = "Error"
      render :index
    end
  end

  private

  def member_params
    params.require(:member).permit(:user)
  end

  def user_in_group?
    @group.users.pluck(:email).include?(member_params[:user])
  end

end
