class CreateFanships < ActiveRecord::Migration
  def self.up
    create_table :fanships do |t|
      t.integer :user_id
      t.integer :favorite_user_id

      t.timestamps
    end

    add_index :fanships, :user_id
    add_index :fanships, :favorite_user_id 

  end

  def self.down
    drop_table :fanships
  end
end
