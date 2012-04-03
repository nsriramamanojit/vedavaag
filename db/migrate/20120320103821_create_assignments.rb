class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.integer :user_id
      t.integer :role_id

      t.integer :created_by
      t.integer :updated_by


      t.timestamps
    end
  end

  def self.down
    drop_table :assignments
  end
end
