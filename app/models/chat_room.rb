class ChatRoom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, through: :chat_room_users
  has_many :chat_room_users

  def get_user_names(current_user)
    (users - [current_user]).map(&:full_name).join(", ")
  end
end
