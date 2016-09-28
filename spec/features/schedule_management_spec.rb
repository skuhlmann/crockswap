require 'rails_helper'

describe 'schedule management', type: :feature do
  describe 'required fields' do
    it "can't create a schedule without all the info" do
      login_user
      visit user_root_path
      page.click_link("Get started")
      page.fill_in('week[start_date]', with: "06/11/2016")
      page.fill_in('week[swap_location]', with: "Parking lot")
      page.fill_in('week[swap_time]', with: "9am")
      page.click_button("Create schedule")

      expect(current_path).to eq(new_group_week_path(@group.name))
      expect(page).to have_content("Please enter all of this info. You can change details later!")
    end
  end

  describe 'sucessful creation' do

    before(:each) do
      login_user
      visit user_root_path
      page.click_link("Get started")
      page.fill_in('week[start_date]', with: "06/11/2016")
      page.fill_in('number_of_weeks', with: "4")
      page.fill_in('week[swap_location]', with: "Parking lot")
      page.fill_in('week[swap_time]', with: "9am")
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
  end
end