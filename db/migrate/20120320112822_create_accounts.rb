class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|

      t.string  :account_number,:null => false
      t.string  :name,:null=>false
      t.string  :mobile, :default=>'N.A'
      t.text    :address
      t.string  :bank_name,:default=>'N.A'
      t.string  :branch_name,:default=>'N.A'
      t.string  :branch_code,:default=>'N.A'
      t.string  :micr_code,:default=>'N.A'
      t.string  :ifsc_code,:default=>'N.A'
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
