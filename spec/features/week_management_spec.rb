require 'rails_helper'

describe 'week management', type: :feature do
  before(:each) do
    login_user
    create_schedule
    visit user_root_path
  end

  describe 'admin' do
    it "can see week details on the group page" do
      page.click_link('Group')

      week = @group.weeks.first

      expect(current_path).to eq(group_path(@group.name))
      expect(page).to have_content("Swapping Schedule")
      expect(page).to have_content("Week of #{week.start_date.strftime("%m/%d")}")
      expect(page).to have_content("Add my meal")
    end


    it "can manage a week" do
      page.click_link('Group')
      page.fill_in('week[swap_location]', match: :first, with: "The beach")
      page.click_button("Update week", match: :first)

      week = Week.all.first

      expect(page).to have_content("Successfully updated.")
      expect(week.swap_location).to eq("The beach")
    end

    it "can pause a week" do
      page.click_link('Group')
      page.check('week[paused]', match: :first)
      page.click_button("Update week", match: :first)

      visit user_root_path
      expect(page).to have_content("Swap paused")
    end
  end

  describe 'non-admin' do
    it "can't change week details" do
      logout
      add_non_admin_user
      visit new_user_session_path
      page.fill_in('user_email', with: @another_user.email)
      page.fill_in('user_password', with: 'password')
      page.click_button('Sign in')
      visit user_root_path
      page.click_link('Group')
      
      week = @group.weeks.first

      expect(current_path).to eq(group_path(@group.name))
      expect(page).to have_content("Week of #{week.start_date.strftime("%m/%d")}")
      expect(page).not_to have_content("Update week")
    end
  end
end