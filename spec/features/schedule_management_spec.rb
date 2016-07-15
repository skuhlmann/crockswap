require 'rails_helper'

describe 'schedule management', type: :feature do

  before(:each) do
    login_user
    visit user_root_path
  end

  it "can create a new schedule" do
    expect(page).to have_content("Now you need to create your swapping schedule.")

    page.click_link("Get started")
    page.fill_in('week[start_date]', with: "06/11/2016")
    page.fill_in('number_of_weeks', with: "4")
    page.choose('week_swap_date_tuesday')
    page.click_button("Create schedule")

    weeks = Week.where(group_id: @group.id)

    expect(current_path).to eq(group_weeks_path(@group.name))
    expect(weeks.count).to eq(4)
    expect(page).to have_content("Hot swappin' devils")
  end

  xit "can add weeks to a schedule" do
    # page.click_link("My groups")
    # page.click_link("group-link", :match => :first)
  end

  xit "can edit swap details for a week" do
  end

  xit "can pause swapping on a week" do
  end
end