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
    user = User.where(email: user_params[:email])

    if user.empty?
      user = User.temporary(user_params[:email])
      if Member.invite(user, @group)
        redirect_to group_members_path(@group.name), alert: "An invite email has been sent."
      else
        redirect_to group_members_path(@group.name), alert: "Error"
      end
    elsif user_in_group?
      redirect_to group_members_path(@group.name), alert: "User is already in this group"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def user_in_group?
    @group.users.pluck(:email).include?(user_params[:email])
  end

end
