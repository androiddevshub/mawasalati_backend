class CreatePassengers < ActiveRecord::Migration[6.1]
  def change
    create_table :passengers do |t|
      t.references :booking, null: false, foreign_key: true
      t.string :name
      t.string :age
      t.string :gender
      t.timestamps
    end
  end
end
