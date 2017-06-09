class AddCssToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :css, :text
  end

  def self.down
    remove_column :users, :css
  end
end
