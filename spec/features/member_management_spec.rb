require 'rails_helper'

describe 'member management', type: :feature do

  before(:each) do
    login_user
  end

  it "can visit the member page" do
    visit group_path(@group.name)
    click_link("Manage swappers")

    expect(current_path).to eq(group_members_path(@group.name))
    expect(page).to have_content("Crock Swappers Members")
    expect(page).to have_content("Invite a Swapmate")
  end

  it "can invite a new member" do
    user_count = User.count

    visit group_path(@group.name)
    click_link("Manage swappers")
    page.fill_in('user[name]', with: 'billy')
    page.fill_in('user[email]', with: 'sam@example.com')
    page.click_button("Send invite")

    mail = ActionMailer::Base.deliveries.last

    expect(current_path).to eq(group_members_path(@group.name))
    expect(page).to have_content("An invite email has been sent.")
    expect(page).to have_content("billy")
    expect(page).to have_content("Pending")
    expect(User.count).to eq(user_count + 1)
  end

  it "can invite an existing user to be a member" do
    other_user = User.create(email: "jim@example.com", password: "password")
    user_count = User.count

    visit group_path(@group.name)
    click_link("Manage swappers")
    page.fill_in('user[name]', with: 'tobin')
    page.fill_in('user[email]', with: 'jim@example.com')
    page.click_button("Send invite")

    mail = ActionMailer::Base.deliveries.last

    expect(current_path).to eq(group_members_path(@group.name))
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
    expect(page).to have_content("That swapper is already in this group.")
  end

  it "can cancel a pending invite" do
    visit group_path(@group.name)
    click_link("Manage swappers")
    page.fill_in('user[email]', with: 'sam@example.com')
    page.fill_in('user[name]', with: 'sam k')
    page.click_button("Send invite")
    visit group_members_path(@group.name)

    member = Member.last
    new_user = User.last

    expect(page).to have_content("sam k")
    expect(page).to have_content("Pending")
    expect(member.user_id).to eq(new_user.id)

    page.click_link("Cancel invite")

    expect(current_path).to eq(group_members_path(@group.name))
    expect(page).not_to have_content("sam k")
    expect(Member.where(id: member.id)).to be_empty
  end
end