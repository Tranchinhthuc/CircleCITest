class OfficeBank < ApplicationRecord
  belongs_to :office
  belongs_to :bank
end
