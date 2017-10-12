class MessagesController < ApplicationController

  def create
    @group = Group.where(name: params[:group_name]).first

    if messages_params[:body].empty? && !messages_params[:picture]
      redirect_to group_swapboard_path(@group.name)
    else
      @message = Message.new(messages_params)
      @group.messages << @message
      current_user.messages << @message
      @message.save
      redirect_to group_swapboard_path(@group.name)
    end

  end

  def destroy
    @group = Group.where(name: params[:group_name]).first
    @message = Message.find(params[:id])
    authorize_owner

    @message.destroy
    redirect_to group_swapboard_path(@group.name)
  end

  private

  def messages_params
    params.require(:message).permit(:body, :picture)
  end

  def authorize_owner
    unless @message.user.id == current_user.id
      redirect_to group_swapboard_path(@group.name)
    end
  end
end