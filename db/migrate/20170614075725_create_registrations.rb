class CreateRegistrations < ActiveRecord::Migration[5.0]
  def change
    create_table :registrations do |t|
      t.integer :office_id
      t.text :message

      t.timestamps
    end
  end
end
