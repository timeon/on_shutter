class CreatePrayers < ActiveRecord::Migration
  def self.up
    create_table :prayers do |t|
      t.references :user
      t.references :prayer_request
      t.text       :body
      t.integer    :vote_count

      t.timestamps
    end

    add_index :prayers, :user_id
    add_index :prayers, :prayer_request_id
  end

  def self.down
    drop_table :prayers
  end
end
