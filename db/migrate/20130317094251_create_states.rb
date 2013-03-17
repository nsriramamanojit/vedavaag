class CreateStates < ActiveRecord::Migration
  def self.up
    create_table :states do |t|

      t.string :name
      t.string :reference_name
      t.string :description
      t.boolean :status, :default=>0

      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end

  def self.down
    drop_table :states
  end
end
