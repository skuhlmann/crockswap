require 'rails_helper'

RSpec.describe Group, type: :model do
  it "exists" do
    group = Group.create!(name: "pot swappers")

    expect(group).to be
  end

  it "must have a unique name" do
    group = create(:group)
    group_2 = Group.create(name: group.name)

    expect(group).to be_valid
    expect(group_2).to be_invalid
  end

  it "must have a positive max participants" do
    group = create(:group)
    group_2 = Group.create(name: "Groupers", max_participants: -5)

    expect(group).to be_valid
    expect(group_2).to be_invalid
  end

  it "can have an admin that belongs to the group" do
    group = create(:group)
    user = create(:user)

    group.users << user
    group.admin = user.id
    expect(group.admin).to eq(user.id)
  end
end
