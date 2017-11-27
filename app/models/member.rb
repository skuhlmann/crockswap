class Member < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  def self.invite(user, group)
    token = Digest::SHA1.hexdigest([Time.now, rand].join)

    new_member = {
      user_id: user.id,
      group_id: group.id,
      invite_token: token,
      invite_sent_at: Time.now,
      status: "Pending"
    }
    create(new_member)

    InviteMailer.invite_email(user, group, token).deliver_now
  end
  
  def self.active
    where(active: true)
  end

  def self.email_opted_in
    where(email_opt: true)
  end

  def join_group
    update(status: "Accepted")
  end
end
