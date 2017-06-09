class AddFieldsToContact2 < ActiveRecord::Migration
  def self.up
    add_column :contacts, :child_5_last_name, :string
  end

  def self.down
    remove_column :contacts, :child_5_last_name
  end
end
