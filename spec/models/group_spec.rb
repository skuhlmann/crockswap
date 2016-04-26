require 'rails_helper'

RSpec.describe Group, type: :model do
  it "exists" do
    group = Group.create!

    expect(group).to be
  end
end
