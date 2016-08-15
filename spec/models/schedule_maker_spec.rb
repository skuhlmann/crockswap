require 'rails_helper'

RSpec.describe ScheduleMaker do
  it "exists" do
    expect(ScheduleMaker).to be
  end

  it "finds the 1st day of the week" do
    start_date = Date.parse('2016-06-25')
    swap_day = 2
    num_of_weeks = 6
    maker = ScheduleMaker.new(start_date, swap_day, num_of_weeks)

    expect(maker.start_date).to eq(Date.parse('2016-06-20'))
  end

  it "creates a week with correct start and swap dates" do
    start_date = Date.parse('2016-06-25')
    swap_day = 2
    num_of_weeks = 1
    maker = ScheduleMaker.new(start_date, swap_day, num_of_weeks)

    week = maker.create_weeks

    expect(week.count).to eq(1)
    expect(week[0].class).to eq(Week)
    expect(week[0].start_date).to eq(Date.parse('2016-06-20'))
    expect(week[0].swap_date).to eq(Date.parse('2016-06-21'))
  end

  it "creates a mulitple weeks" do
    start_date = Date.parse('2016-06-25')
    swap_day = 2
    num_of_weeks = 4
    maker = ScheduleMaker.new(start_date, swap_day, num_of_weeks)

    week = maker.create_weeks

    expect(week.count).to eq(4)
    expect(week[1].start_date).to eq(Date.parse('2016-06-27'))
    expect(week[2].start_date).to eq(Date.parse('2016-07-04'))
    expect(week[3].start_date).to eq(Date.parse('2016-07-11'))
    expect(week[1].swap_date).to eq(Date.parse('2016-06-28'))
    expect(week[2].swap_date).to eq(Date.parse('2016-07-05'))
    expect(week[3].swap_date).to eq(Date.parse('2016-07-12'))
  end
end
