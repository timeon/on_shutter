class AddReferrerUrlToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :referrer_url_id, :integer
  end

  def self.down
    remove_column :users, :referrer_url_id
  end
end
