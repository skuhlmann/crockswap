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

  def logout
    page.click_link('Sign out')
  end

  def add_non_admin_user
    @another_user = User.create(email: "bill@example.com", name: "bill", password: "password")
    @another_user.skip_confirmation!
    @another_user.save!
    @group.users << @another_user
  end

  def create_schedule
    start = Date.today
    defaults = {swap: 2, location: "home", time: "3pm"}
    number = 3
    weeks = ScheduleMaker.new(start, defaults, number).create_weeks
    Week.transaction do
      weeks.each do |week|
        week.group_id = @group.id
        week.save!
      end
    end
  end
end