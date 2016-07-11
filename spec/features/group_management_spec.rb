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
    visit user_root_path
    page.click_link("My groups")
    page.click_link("group-link", :match => :first)

    expect(current_path).to eq(group_path(@group.name))
    expect(page).to have_content("Week planner")
  end

  it "user can't visit a group page it doesn't belong to" do
    group2 = Group.create(name: "Men with crocks")
    visit group_path(group2.name)

    expect(current_path).to eq(user_root_path)
  end

  it "can manage the group details" do
    visit user_root_path
    page.click_link("My groups")
    page.click_link("group-link", :match => :first)
    page.click_link("Settings")

    expect(current_path).to eq(edit_group_path(@group.name))
    expect(page).to have_content("Group Settings")

    page.fill_in('group_max_participants', with: "666")
    page.click_button("Update group")

    expect(current_path).to eq(group_path(@group.name))
    expect(page).to have_content("666")
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
    another_user = User.create(email: "bill@example.com", name: "bill", password: "password")
    another_user.skip_confirmation!
    another_user.save!
    @group.users << another_user
    @group.save
    visit new_user_session_path
    page.fill_in('user_email', with: another_user.email)
    page.fill_in('user_password', with: 'password')
    page.click_button('Sign in')

    visit user_root_path
    page.click_link("My groups")
    page.click_link("group-link", :match => :first)

    expect(page).not_to have_content("Settings")
    expect(page).not_to have_content("Manage swappers")
  end
end