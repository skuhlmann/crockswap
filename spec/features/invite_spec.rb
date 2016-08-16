require 'rails_helper'

describe 'invite', type: :feature do

  before(:each) do
    @user = create(:user)
    @group = create(:group)
    @group.admin = @user.id
    week = build(:week)
    @group.weeks << week
    @group.save
    @invite_user = User.create(email: "coll@example.com", name: "coll", password: "password", temporary: true)
    @invite_user.skip_confirmation!
    @invite_user.save!
    Member.invite(@invite_user, @group)
  end

  it "can't join a group on an expired token" do
    bad_token = "thisisnogood"

    visit invite_confirmation_path(bad_token)

    expect(current_path).to eq(root_path)
  end

  it "unregistered users can join the group from an invite" do
    member = Member.last

    visit invite_confirmation_path(member.invite_token)

    expect(Member.last.status).to eq("Accepted")
    expect(current_path).to eq(complete_profile_path(@invite_user))
    expect(page).to have_content("Please finish filling out your profile to continue")
  end

  it "unregistered users can join the group from an invite and complete their sign up" do
    member = Member.last

    visit invite_confirmation_path(member.invite_token)
    page.fill_in('user_password', with: 'password')
    page.fill_in('user_password_confirmation', with: 'password')
    page.click_button("Complete profile")

    updated_user = User.find(@invite_user.id)

    expect(updated_user.temporary).to be(false)
    expect(current_path).to eq(user_root_path(@invite_user))
    expect(page).to have_content("Crock Swappers")
  end

  it "unregistered users can join the group from an must enter a password" do
    member = Member.last

    visit invite_confirmation_path(member.invite_token)
    page.click_button("Complete profile")

    expect(page).to have_content("Password and matching confirmation are required")
    expect(page.current_path).to eq(complete_profile_path(member.user.id))
  end


  it "registered users can join the group from an invite" do
    @another_invite_user = User.create(email: "bill@example.com", name: "bill", password: "password", temporary: false)
    @another_invite_user.skip_confirmation!
    @another_invite_user.save!
    Member.invite(@another_invite_user, @group)
    member = Member.last

    visit invite_confirmation_path(member.invite_token)
    expect(current_path).to eq(user_root_path(@another_invite_user))
    expect(page).to have_content("Crock Swappers")
  end
end