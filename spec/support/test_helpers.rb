module TestHelpers
  def login_user
    @user = build(:user)
    @group = create(:group)
    @user.skip_confirmation!
    @user.save
    @group.users << @user
    @group.admin = @user.id
    @group.save
    visit new_user_session_path
    page.fill_in('user_email', with: @user.email)
    page.fill_in('user_password', with: 'password')
    page.click_button('Sign in')
  end
end