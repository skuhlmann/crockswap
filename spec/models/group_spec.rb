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
end
