class MessagesController < ApplicationController
  def create
    message = Message.new(message_params)
    message.user = current_user
    if message.save
      ActionCable.server.broadcast 'messages',
        message: message.content,
        chat_room_id: params[:message][:chat_room_id],
        avatar: current_user.avatar_url(:comment_avatar),
        user: {name: current_user.full_name, id: current_user.id}
      head :ok
    else
      redirect_to chat_rooms_path
    end
  end

  private
    def message_params
      params.require(:message).permit(:content, :chat_room_id)
    end
end
