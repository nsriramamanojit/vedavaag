class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|

      t.string  :account_number,:null => false
      t.string  :name,:null=>false
      t.string  :mobile,:null=>false
      t.text    :address
      t.string  :bank_name,:null=>false
      t.string  :branch_name
      t.string  :branch_code
      t.string  :micr
      t.string  :ifsc,:length=>11
      t.text    :remarks
      t.boolean :status,:default=>1

      t.integer :created_by
      t.integer :modified_by


      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
