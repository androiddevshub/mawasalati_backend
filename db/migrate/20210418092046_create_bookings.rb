class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.references :scheduled_bus, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :booking_id
      t.string :date
      t.decimal :tax_fare, precision: 10, scale: 2
      t.decimal :passenger_fare, precision: 10, scale: 2
      t.decimal :total_fare, precision: 10, scale: 2
      t.string :email
      t.string :phone
      t.string :status
      t.timestamps
    end
  end
end
