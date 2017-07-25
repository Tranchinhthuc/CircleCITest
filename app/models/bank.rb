class Bank < ApplicationRecord
  has_many :offices, through: :office_banks
  has_many :office_banks
end
