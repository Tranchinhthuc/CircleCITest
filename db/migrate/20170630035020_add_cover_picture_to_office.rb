class AddCoverPictureToOffice < ActiveRecord::Migration[5.0]
  def change
    add_column :offices, :cover_picture, :string
  end
end
