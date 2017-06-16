class CreateDistricts < ActiveRecord::Migration[5.0]
  def change
    create_table :districts do |t|
      t.string :name
      t.integer :city_id
      t.integer :order_number
      t.text :description

      t.timestamps
    end
  end
end
