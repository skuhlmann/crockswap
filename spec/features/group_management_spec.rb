require 'rails_helper'

describe 'group managment', type: :feature do

  before(:each) do
    login_user
  end

  it "can create a new group" do
    visit new_groups_path

    page.fill_in('group_name', with: "Hot swappin' devils")
    page.fill_in('group_max_participants', with: "4")
    page.fill_in('group_budget', with: "$30")
    page.click_button("Create group")

    expect(page).to have_content("Success")
    expect(page).to have_content("My groups")
    expect(page).to have_content("Hot swappin' devils")
  end
end