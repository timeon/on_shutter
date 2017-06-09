class AddKeyToContact < ActiveRecord::Migration
  def self.up
    add_column :contacts, :key, :string
  end

  def self.down
    remove_column :contacts, :key
  end
end
