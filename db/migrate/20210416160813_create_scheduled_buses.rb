class CreateScheduledBuses < ActiveRecord::Migration[6.1]
  def change
    create_table :scheduled_buses do |t|
      t.references :bus, null: false, foreign_key: true
      t.string :origin
      t.string :destination
      t.string :departure_center
      t.string :arrival_center
      t.string :departure_time
      t.string :arrival_time
      t.decimal :duration, precision: 5, scale: 2
      t.integer :seats
      t.string :date
      t.integer :price
      t.integer :rating
      t.timestamps
    end
  end
end
