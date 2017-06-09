class AddInfoToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :website, :string
    add_column :users, :location, :string
    add_column :users, :about_me, :text
    add_column :users, :real_name, :string
    add_column :users, :birthday, :date
    add_column :users, :seen, :datetime
    add_column :users, :reputation_count, :integer, :default => 0
    add_column :users, :view_count, :integer, :default => 0
    add_column :users, :profile_photo_id, :integer
    add_column :users, :copyright, :string, :default => "All rights reserved."

  end

  def self.down
    remove_column :users, :copyright
    remove_column :users, :profile_photo_id
    remove_column :users, :view_count
    remove_column :users, :reputation_count
    remove_column :users, :seen
    remove_column :users, :birthday
    remove_column :users, :real_name
    remove_column :users, :about_me
    remove_column :users, :location
    remove_column :users, :website
  end
end
