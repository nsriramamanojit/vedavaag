class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.string :name
      t.date :date
      t.text :remarks
      t.string :transfer_account
      t.string :transfer_branch_code

      t.string :attachment_file_name
      t.string :attachment_content_type
      t.integer :attachment_file_size
      t.datetime :attachment_updated_at

      t.boolean :status,:default=>1

      t.integer :created_by
      t.integer :modified_by


      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
