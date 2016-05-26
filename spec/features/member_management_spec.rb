require 'rails_helper'

describe 'member management', type: :feature do

  before(:each) do
    login_user
  end

  it "can visit the member page" do
    visit group_path(@group.name)
    click_link("Manage swappers")

    expect(current_path).to eq(group_members_path(@group.name))
    expect(page).to have_content("Crock Swappers")
    expect(page).to have_content("Invite a swapper")
  end

  it "can invite a new member" do
    user_count = User.count

    visit group_path(@group.name)
    click_link("Manage swappers")
    page.fill_in('user[email]', with: 'sam@example.com')
    page.click_button("Send invite")

    mail = ActionMailer::Base.deliveries.last

    expect(current_path).to eq(group_members_path(@group.name))
    expect(page).to have_content("An invite email has been sent.")
    expect(mail.to.first).to eq("sam@example.com")
    expect(User.count).to eq(user_count + 1)
  end

  it "can invite an existing user to be a member" do
    other_user = User.create(email: "jim@example.com", password: "password")
    user_count = User.count

    visit group_path(@group.name)
    click_link("Manage swappers")
    page.fill_in('user[email]', with: 'jim@example.com')
    page.click_button("Send invite")

    mail = ActionMailer::Base.deliveries.last

    expect(current_path).to eq(group_members_path(@group.name))
    expect(page).to have_content("An invite email has been sent.")
    expect(mail.to.first).to eq("jim@example.com")
    expect(User.count).to eq(user_count)
  end

  it "can't invite an existing member to be a member" do
    other_user = User.create(email: "jim@example.com", password: "password")
    @group.users << other_user
    @group.save

    visit group_path(@group.name)
    click_link("Manage swappers")
    page.fill_in('user[email]', with: 'jim@example.com')
    page.click_button("Send invite")

    expect(current_path).to eq(group_members_path(@group.name))
    expect(page).to have_content("User is already in this group.")
  end
end