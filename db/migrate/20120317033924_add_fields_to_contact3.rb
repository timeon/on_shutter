class AddFieldsToContact3 < ActiveRecord::Migration
  def self.up
    add_column :contacts, :child_1_chinese_name, :string
    add_column :contacts, :child_2_chinese_name, :string
    add_column :contacts, :child_3_chinese_name, :string
    add_column :contacts, :child_4_chinese_name, :string
    add_column :contacts, :child_5_chinese_name, :string
  end

  def self.down
    remove_column :contacts, :child_5_chinese_name
    remove_column :contacts, :child_4_chinese_name
    remove_column :contacts, :child_3_chinese_name
    remove_column :contacts, :child_2_chinese_name
    remove_column :contacts, :child_1_chinese_name
  end
end
