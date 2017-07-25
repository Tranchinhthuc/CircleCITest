class CreateRegistrations < ActiveRecord::Migration[5.0]
  def change
    create_table :registrations do |t|
      t.integer :office_id
      t.text :message
      t.integer :user_id
      t.string :title
      t.string :name

      t.timestamps
    end
  end
end
