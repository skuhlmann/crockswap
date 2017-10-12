require 'rails_helper'

RSpec.describe Message, type: :model do
  it "exists" do
    message = create(:message)

    expect(message).to be_valid
    expect(message.body).to eq("I have someting to say!")
  end

  it "can belong to a group and a user" do
    user = build(:user)
    group = create(:group)
    user.skip_confirmation!
    user.save
    group.users << user
    message = create(:message)

    message.group = group
    message.user = user

    message.save


    expect(group.messages.first.body).to eq("I have someting to say!")
    expect(user.messages.first.body).to eq("I have someting to say!")
  end
end