class CreateBuses < ActiveRecord::Migration[6.1]
  def change
    create_table :buses do |t|
      t.string :name
      t.string :bus_type
      t.string :operator_contact_first
      t.string :operator_contact_second
      t.timestamps
    end
  end
end
