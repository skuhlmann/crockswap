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
end
