class MembersController < GroupsController
  before_action :authenticate_user!, except: [:invite]
  before_action :set_view_active

  def index
    authorize_user_group(params[:group_name])
    @members = Member.where(group_id: @group.id)
    @member = Member.new
  end

  def new
    authorize_user_group(params[:group_name])
    @member = Member.new
  end

  def create
    authorize_user_group(params[:group_name])
    if user_in_group?
      return redirect_to group_members_path(@group.name), alert: "User is already in this group."
    end

    email = user_params[:email].downcase
    user = User.where(email: email).first
    if user.nil?
      user = User.temporary(user_params)
    end

    Member.invite(user, @group)
    redirect_to group_members_path(@group.name), alert: "An invite email has been sent."
  end

  def invite
    if !valid_invite?
      return redirect_to root_path, alert: "Invalid Invite"
    end

    @user = User.find(@member.user_id)

    if @member.status == "Accepted"
      return redirect_to user_root_path(@user), alert: "Already a group member"
    elsif @member.status == "Pending"
      @member.join_group

      if @user.temporary
        return redirect_to complete_profile_path(@user)
      else
        bypass_sign_in(@user)
        redirect_to user_root_path(@user), notice: "You've been added to the group"
      end
    end
  end

  def destroy
    authorize_admin(params[:group_name])
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to group_members_path(@group.name), alert: "Invite cancelled"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def user_in_group?
    @group.users.pluck(:email).include?(user_params[:email])
  end

  def valid_invite?
    @member = Member.where(invite_token: params[:invite_token]).first
    if @member
      @member.invite_sent_at > 5.days.ago
    end
  end

  def set_view_active
    @active_group_view_path = "group_active"
  end
end
