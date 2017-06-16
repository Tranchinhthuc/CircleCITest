class CreateOfficeDistricts < ActiveRecord::Migration[5.0]
  def change
    create_table :office_districts do |t|
      t.integer :office_id
      t.integer :district_id

      t.timestamps
    end
  end
end
