require 'rails_helper'

describe 'group managment', type: :feature do

  before(:each) do
    login_user
  end

  it "can create a new group" do
    visit new_group_path

    page.fill_in('group_name', with: "Hot swappin' devils")
    page.fill_in('group_budget', with: "$30")
    page.click_button("Create group")

    expect(current_path).to eq(group_swapboard_path("Hot swappin' devils"))
    expect(page).to have_content("Hot swappin' devils")
  end

  it "can visit the group page" do
    visit user_root_path
    page.click_link("Group")

    expect(current_path).to eq(group_path(@group.name))
    expect(page).to have_content("Settings")
    expect(page).to have_content("Manage swappers")
  end

  it "user can't visit a group page it doesn't belong to" do
    group2 = Group.create(name: "Men with crocks")
    visit group_path(group2.name)

    expect(current_path).to eq(user_root_path)
  end

  it "can manage the group details" do
    visit user_root_path
    page.click_link("Group")

    expect(current_path).to eq(group_path(@group.name))
    expect(page).to have_content("Crock Swappers")
    expect(page).to have_content("Group Settings")

    page.fill_in('group_budget', with: "666")
    page.click_button("Update group")
    updated_group = Group.find(@group.id)

    expect(current_path).to eq(group_path(@group.name))
    expect(updated_group.budget).to eq(666.00)
  end

  it "is automatically set to admin when creating a group" do
    visit new_group_path

    page.fill_in('group_name', with: "Hot Dogs")
    page.click_button("Create group")

    new_group = Group.where(name: "Hot Dogs").first

    expect(new_group.admin).to eq(@user.id)
  end

  it "non-admin can't manage the group details" do
    logout
    add_non_admin_user

    week = build(:week)
    @group.weeks << week
    @group.save
    visit new_user_session_path
    page.fill_in('user_email', with: @another_user.email)
    page.fill_in('user_password', with: 'password')
    page.click_button('Sign in')

    visit user_root_path
    page.click_link("Group")

    expect(page).to have_content("Crock Swappers")
    expect(page).to have_content("Group Settings")
    expect(page).not_to have_content("Manage swappers")
  end
end