class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.string :name
      t.string :description
      t.text :remarks
      t.decimal :request_amount, :precision => 10, :scale => 2

      t.date :transaction_date
      t.string :transaction_id

      t.date :approve_date
      t.string :approve_id
      t.string :approve_remarks

      t.decimal :paid_amount, :precision=>10, :scale =>2
      t.date :payment_date
      t.string :payment_id
      t.string :payment_remarks

      t.boolean :status,:default=>0
      t.boolean :approve_status, :default=>0
      t.boolean :fund_status,:default=>0

      t.string :attachment_file_name
      t.string :attachment_content_type
      t.integer :attachment_file_size
      t.datetime :attachment_updated_at

      t.integer :requested_by
      t.integer :approved_by
      t.integer :payment_by


      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
