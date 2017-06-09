class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.integer :user_id
      t.string  :provider
      t.string  :uid
      t.string  :name
      t.string  :email

      t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end
