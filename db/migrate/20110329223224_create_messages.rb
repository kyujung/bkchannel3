class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :body
      t.string :nickname
      t.string :receiver
      t.datetime :created_at

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
