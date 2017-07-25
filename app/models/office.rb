class Office < ApplicationRecord
  mount_uploader :cover_picture, PhotoUploader
  ratyrate_rateable "quality", "attitude"

  has_many :banks, through: :office_banks
  has_many :office_banks

  has_many :districts, through: :office_districts
  has_many :office_districts

  has_many :services, through: :office_services
  has_many :office_services

  has_many :registrations
  has_many :comments, dependent: :destroy

  belongs_to :user
  belongs_to :city

  enum status: {
    active: 1,
    inactive: 2
  }

  def is_belongs_to_user? user_id
    self.user_id == user_id
  end
end
