require 'rails_helper'

RSpec.describe User, type: :model do
  it "requires email and password" do
    user = User.create!(email: "sam@example.com", password: "password")

    expect(user).to be_valid
  end

  it "can belong to groups" do
    user = create(:user)
    group = create(:group)
    group.users << user

    expect(user.groups.first.id).to eq(group.id)
    expect(group.users.first.id).to eq(user.id)
  end

  it "can be a temporary user after invite" do
    group = create(:group)
    admin_user = create(:user)
    group.users << admin_user
    group.admin = admin_user.id
    group.save
    new_user = { email: "paul@example.com", name: "Paul" }
    user = User.temporary(new_user)

    Member.invite(user, group)

    status = user.invite_status(group)

    expect(status).to eq("Pending")
  end
end
