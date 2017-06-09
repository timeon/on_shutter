class CreatePrayerRequests < ActiveRecord::Migration
  def self.up
    create_table :prayer_requests do |t|
      t.references :user
      t.string     :title
      t.text       :body
      t.integer    :vote_count
      t.integer    :view_count, :default => 0

      t.timestamps
    end

    add_index :prayer_requests, :user_id

  end

  def self.down
    drop_table :prayer_requests
  end
end
