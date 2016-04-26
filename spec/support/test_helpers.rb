module TestHelpers
  def login_user
    @user = build(:user)
    @user.skip_confirmation!
    @user.save!
    visit new_user_session_path
    page.fill_in('user_email', with: @user.email)
    page.fill_in('user_password', with: 'password')
    page.click_button('Sign in')
  end
end