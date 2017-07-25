class AddCityIdToOffice < ActiveRecord::Migration[5.0]
  def change
    add_column :offices, :city_id, :integer
  end
end
