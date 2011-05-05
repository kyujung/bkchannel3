class CreateSeats < ActiveRecord::Migration
  def self.up
    create_table :seats do |t|
      t.integer :seatno
      t.string  :nickname

      t.timestamps
    end
  end

  def self.down
    drop_table :seats
  end
end
