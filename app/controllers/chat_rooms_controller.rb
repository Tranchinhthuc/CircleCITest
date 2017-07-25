class ChatRoomsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @chat_rooms = current_user.chat_rooms.includes(:users)
  end

  def show
    @chat_room = ChatRoom.find(params[:id])
    @chat_rooms = current_user.chat_rooms.includes(:users)
    @messages = @chat_room.messages.where("content is not null").last(20)
    @message = Message.new

    respond_to do |format|
      format.js
    end
  end

  def create
    office = Office.find(params[:office_id])
    office_user = office.user

    chat_rooms = current_user.chat_rooms
    chat_room = chat_rooms.find{|chat_room| chat_room.user_ids.sort == [current_user.id, office_user.id].sort}

    unless chat_room.present?
      chat_room = ChatRoom.create(name: "#{current_user.full_name} #{office_user.full_name}", users: [current_user, office_user])
    end

    redirect_to chat_rooms_path(chat_room_id: chat_room.id)
  end
end
