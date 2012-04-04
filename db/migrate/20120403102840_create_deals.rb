class CreateDeals < ActiveRecord::Migration
  def self.up
    create_table :deals do |t|
      t.integer :transaction_id
      t.string :account_number
      t.string :name
      t.string :branch_code
      t.decimal :amount



      t.timestamps
    end
  end

  def self.down
    drop_table :deals
  end
end
