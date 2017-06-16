class CreateOfficeServices < ActiveRecord::Migration[5.0]
  def change
    create_table :office_services do |t|
      t.integer :office_id
      t.integer :service_id

      t.timestamps
    end
  end
end
