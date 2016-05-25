class InviteMailer < ActionMailer::Base
  default from: 'fromcrockswap@gmail.com'

  def invite_email(user, group)
    @user = user
    @group = group
    @group_admin = User.find(@group.admin)

    mail(to: @user.email,
         subject: "#{@group_admin.name} has invited to Crockswap!")
  end
end
