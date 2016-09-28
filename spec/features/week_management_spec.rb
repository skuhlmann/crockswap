require 'rails_helper'

describe 'week management', type: :feature do
  before(:each) do
    login_user
    create_schedule
    visit user_root_path
  end

  describe 'admin' do
    it "can visit a week page" do
      page.click_link("Calendar")
      page.click_link('Week details', match: :first)

      week = @group.weeks.first

      expect(current_path).to eq(group_week_path(@group.name, week))
      expect(page).to have_content("#{@group.name}'s Week of #{week.start_date.strftime("%m/%d/%Y")}")
      expect(page).to have_content("Add my meal")
    end


    it "can manage a week" do
      page.click_link("Calendar")
      page.click_link('Week details', match: :first)
      page.fill_in('week[swap_location]', with: "The beach")
      page.click_button("Update week")

      week = Week.all.first

      expect(page).to have_content("Successfully updated.")
      expect(week.swap_location).to eq("The beach")
    end

    xit "can pause a week" do
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
      page.click_link('Calendar')
      page.click_link('Week details', match: :first)
      
      week = @group.weeks.first

      expect(current_path).to eq(group_week_path(@group.name, week))
      expect(page).to have_content("#{@group.name}'s Week of #{week.start_date.strftime("%m/%d/%Y")}")
      expect(page).not_to have_content("Update week")
    end
  end
end