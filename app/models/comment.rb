class Comment < ApplicationRecord
  belongs_to :office
  belongs_to :user

  belongs_to :parent, :class_name => "Comment", :foreign_key => "parent_id"
  has_many :replies, :class_name => "Comment", :foreign_key => "parent_id", dependent: :destroy

  scope :root_comments, -> { where(parent_id: nil) }

  def user_name
    if user.present?
      user.full_name
    else
      "Anonymous"
    end
  end

  def is_root?
    !parent.present?
  end
end
