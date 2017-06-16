class CreateOfficeBanks < ActiveRecord::Migration[5.0]
  def change
    create_table :office_banks do |t|
      t.integer :office_id
      t.integer :bank_id

      t.timestamps
    end
  end
end
