class MessagesController < ApplicationController

  def create
    @group = Group.where(name: params[:group_name]).first
    @message = Message.new(messages_params)
    @group.messages << @message
    current_user.messages << @message

    if @message.save
      redirect_to group_swapboard_path(@group.name)
    else
      flash[:alert] = "Add a message."
      redirect_to group_swapboard_path(@group.name)
    end
  end

  def messages_params
    params.require(:message).permit(:body)
  end
end