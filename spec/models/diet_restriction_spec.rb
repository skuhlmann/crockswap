require 'rails_helper'

RSpec.describe DietRestriction, type: :model do
  it "exists" do
    restriction = create(:diet_restriction)

    expect(restriction).to be_valid
  end

  it "can belong to groups" do
    restriction = create(:diet_restriction)
    group = create(:group)
    group.diet_restrictions << restriction

    expect(group.diet_restrictions.first.id).to eq(restriction.id)
  end

  it "can belong to users" do
    restriction = create(:diet_restriction)
    user = create(:user)
    user.diet_restrictions << restriction

    expect(user.diet_restrictions.first.id).to eq(restriction.id)
  end
end
