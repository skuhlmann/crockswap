require 'rails_helper'

describe 'schedule management', type: :feature do

  before(:each) do
    login_user
    visit user_root_path
    page.click_link("Get started")
    page.fill_in('week[start_date]', with: "06/11/2016")
    page.fill_in('number_of_weeks', with: "4")
    page.choose('week_swap_date_tuesday')
    page.click_button("Create schedule")
  end

  it "can create a new schedule" do
    weeks = Week.where(group_id: @group.id)

    expect(current_path).to eq(group_weeks_path(@group.name))
    expect(weeks.count).to eq(4)
    expect(page).to have_content("Crock Swappers Swapping Schedule")
  end

  xit "can add weeks to a schedule" do
    visit user_root_path
    page.click_link("Check out your swapping schedule")

    expect(current_path).to eq(group_weeks_path(@group.name))

    page.fill_in('number_of_weeks', with: "1")
    page.click_link("Add")

    weeks = Week.where(group_id: @group.id)

    expect(current_path).to eq(group_weeks_path(@group.name))
    expect(weeks.count).to eq(5)
  end

  xit "can edit swap details for a week" do
  end

  xit "can pause swapping on a week" do
  end
end