class AddFieldsToContact < ActiveRecord::Migration
  def self.up
    add_column :contacts, :adult_1_cell_phone, :string
    add_column :contacts, :adult_2_cell_phone, :string
    add_column :contacts, :child_1_last_name, :string
    add_column :contacts, :child_2_last_name, :string
    add_column :contacts, :child_3_last_name, :string
    add_column :contacts, :child_4_last_name, :string
  end

  def self.down
    remove_column :contacts, :child_4_last_name
    remove_column :contacts, :child_3_last_name
    remove_column :contacts, :child_2_last_name
    remove_column :contacts, :child_1_last_name
    remove_column :contacts, :adult_2_cell_phone
    remove_column :contacts, :adult_1_cell_phone
  end
end
