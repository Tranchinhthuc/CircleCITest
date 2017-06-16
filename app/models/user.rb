class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :avatar, PhotoUploader

  devise :database_authenticatable, :registerable, :rememberable, :recoverable,
         :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  scope :index, -> { all }

  enum role: {
    admin: 1,
    normal: 2
  }

  def admin?
    role == "admin"
  end

  def normal?
    role == "normal"
  end

  def generate_authentication_token!
    begin
      self.authentication_token = Devise.friendly_token
    end while self.class.exists?(authentication_token: authentication_token)
  end

  def find_friends
    graph = Koala::Facebook::API.new(facebook_token)
    friend_uids = graph.get_connections("me", "friends").map{|friend| friend["id"]}
    friends = User.where(uid: friend_uids)
  end

  def self.create_new_user_with_facebook_account(auth)
    uid = auth.uid
    email = auth.info.email.nil? ? "#{uid}@toeictest.com" : auth.info.email
    full_name = auth.info.name.nil? ? email : auth.info.name
    create( provider: auth.provider, uid: uid, email: email, full_name: full_name,
            password: Devise.friendly_token[0,20],
            facebook_token: auth.credentials.token,
            remote_avatar_url: auth.info.image.gsub('http:','https:')+"?fields=picture&type=large",
            point: 0
          )
  end

  def self.find_user_by_facebook_info(auth)
    unless user = User.find_by(provider: auth.provider, uid: auth.uid)
      if user = User.find_by(email: auth.info.email)
        user.update_attributes(provider: auth.provider,
          uid: auth.uid, facebook_token: auth.credentials.token,
          remote_avatar_url: auth.info.image.gsub('http:','https:')+"?fields=picture&type=large")
      end
    end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
