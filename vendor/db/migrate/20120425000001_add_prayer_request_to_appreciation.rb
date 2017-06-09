class AddPrayerRequestToAppreciation < ActiveRecord::Migration
  def self.up
    add_column :appreciations, :prayer_request_id, :integer
    add_index :appreciations, :prayer_request_id
  end

  def self.down
    remove_column :appreciations, :prayer_request_id
  end
end
