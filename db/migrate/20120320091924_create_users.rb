class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      # User Account
      t.string :login

      #General Details
      t.string :email
      t.string :name
      t.string :mobile_number
      t.string :phone_number
      t.integer :state_id
      t.integer :project_id

      #Password and Login Details
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token, :null => false
      t.string :perishable_token, :default=>"", :null=>false
      t.integer :login_count, :default => 0, :null => false
      t.integer :created_by
      t.integer :updated_by
      t.datetime :last_request_at
      t.datetime :last_login_at
      t.datetime :current_login_at
      t.string :last_login_ip
      t.string :current_login_ip
      t.boolean :status, :default=>1

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
