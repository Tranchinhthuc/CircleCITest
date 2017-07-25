class AddStatusToOffice < ActiveRecord::Migration[5.0]
  def change
    add_column :offices, :status, :integer, :default => 1
  end
end
