require 'rails_helper'

describe 'member managment', type: :feature do

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
    visit group_path(@group.name)
    click_link("Manage swappers")

    page.fill_in('member[user]', with: 'colleen@example.com')
    page.click_button("Send invite")

    expect(current_path).to eq(group_members_path(@group.name))

    expect(page).to have_content("An invite email has been sent.")
    expect(ActionMailer::Base.deliveries.length).to eq(1)
  end
end