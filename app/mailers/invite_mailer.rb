class InviteMailer < ActionMailer::Base
  default from: 'fromcrockswap@gmail.com'

  def invite_email(user, group, token)
    @user = user
    @group = group
    @group_admin = User.find(@group.admin)
    @token = token

    mail(to: @user.email,
         subject: "#{@group_admin.name} has invited you to Crockswap!")
  end
end
