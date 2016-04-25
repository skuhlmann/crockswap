require 'rails_helper'

describe 'user managment', type: :feature do

  it "can register for a new account" do
    ActionMailer::Base.deliveries = []

    visit new_user_session_path
    page.click_link("Sign up")

    expect(current_path).to eq(new_user_registration_path)

    page.fill_in('user_email', with: 'colleen@example.com')
    page.fill_in('user_password', with: 'password')
    page.fill_in('user_password_confirmation', with: 'password')
    page.click_button("Sign up")

    expect(current_path).to eq(new_user_session_path)

    expect(page).to have_content("A message with a confirmation link has been sent to your email address.")
    expect(ActionMailer::Base.deliveries.length).to eq(1)
  end

  it "can login to an existing account" do
    user = User.create(email: "colleen@example.com", password: "password")
    user.confirm

    visit new_user_session_path
    expect(page).to have_content('Sign in')

    page.fill_in('user_email', with: user.email)
    page.fill_in('user_password', with: 'password')
    page.click_button('Sign in')

    expect(current_path).to eq(user_root_path)
    expect(page).to have_content('Sign out')
    expect(page).to have_content(user.email)
  end

  it "can't login to an non-existing account" do
    visit new_user_session_path
    expect(page).to have_content('Sign in')

    page.fill_in('user_email', with: 'sam@example.com')
    page.fill_in('user_password', with: 'password')
    page.click_button('Sign in')

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('Invalid email or password.')
  end

  it "can request a forgotten password" do
    user = User.create(email: "colleen@example.com", password: "password")
    user.confirm
    ActionMailer::Base.deliveries = []

    visit new_user_session_path
    page.click_link("Forgot your password?")

    expect(current_path).to eq(new_user_password_path)

    page.fill_in("user_email", with: 'colleen@example.com')
    page.click_button('Send me reset password instructions')

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content("You will receive an email with instructions")
    expect(ActionMailer::Base.deliveries.length).to eq(1)
    expect(ActionMailer::Base.deliveries[0].to[0]).to eq("colleen@example.com")
  end

  it "can login and signout" do
    user = User.create(email: "colleen@example.com", password: "password")
    user.confirm

    visit new_user_session_path
    page.fill_in('user_email', with: 'colleen@example.com')
    page.fill_in('user_password', with: 'password')
    page.click_button('Sign in')

    page.click_link('Sign out')
    expect(current_path).to eq(root_path)
  end

  it "can edit a profile" do
    user = User.create(email: "colleen@example.com", password: "password")
    user.confirm

    visit new_user_session_path
    page.fill_in('user_email', with: 'colleen@example.com')
    page.fill_in('user_password', with: 'password')
    page.click_button('Sign in')

    page.click_link("My profile")
    expect(current_path).to eq(edit_profile_path(user))

    page.fill_in('Name', with: 'Colleen')
    page.click_button("Update profile")

    expect(page).to have_content("Successfully updated")
    expect(User.where(name: "Colleen").length).to be(1)
  end
end