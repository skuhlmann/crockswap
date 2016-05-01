require 'rails_helper'

describe 'group managment', type: :feature do

  before(:each) do
    login_user
  end

  it "can create a new group" do
    visit new_group_path

    page.fill_in('group_name', with: "Hot swappin' devils")
    page.fill_in('group_max_participants', with: "4")
    page.fill_in('group_budget', with: "$30")
    page.click_button("Create group")

    expect(page).to have_content("My groups")
    expect(page).to have_content("Hot swappin' devils")
  end

  it "can visit the group page" do
    group = create(:group)
    group.users << @user

    visit user_root_path
    page.click_link("group-link")

    expect(current_path).to eq(group_path(group.name))
    expect(page).to have_content("Week planner")
  end

  it "user can't visit a group page it doesn't belong to" do
    group = create(:group)

    visit group_path(group.name)

    expect(current_path).to eq(user_root_path)
  end

  it "can manage the group details" do
    group = create(:group)
    group.users << @user

    visit user_root_path
    page.click_link("group-link")
    page.click_link("Settings")

    expect(current_path).to eq(edit_group_path(group.name))
    expect(page).to have_content("Group Settings")

    page.fill_in('group_max_participants', with: "666")
    page.click_button("Update group")

    expect(current_path).to eq(group_path(group.name))
    expect(page).to have_content("666")
  end
end