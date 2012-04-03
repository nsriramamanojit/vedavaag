class CreateDeals < ActiveRecord::Migration
  def self.up
    create_table :deals do |t|
      t.integer :transaction_id
      t.integer :account_number
      t.decimal :amount



      t.timestamps
    end
  end

  def self.down
    drop_table :deals
  end
end
