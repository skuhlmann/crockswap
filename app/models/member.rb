class Member < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  def self.invite(user, group)
    token = Digest::SHA1.hexdigest([Time.now, rand].join)

    new_member = {
      user_id: user.id,
      group_id: group.id,
      invite_token: token
    }

    create(new_member)

    #now create the invite token and trigger the email

  end
end
