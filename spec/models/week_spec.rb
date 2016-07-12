require 'rails_helper'

RSpec.describe Week, type: :model do
  it "exists" do
    week = create(:week)
    start = Date.parse('2016-06-25')

    expect(week).to be_valid
    expect(week.start_date).to eq(start)
  end

  it "can belongs to  a group" do
    week = create(:week)
    group = create(:group)
    group.weeks << week

    expect(group.weeks.first.id).to eq(week.id)
  end
end
