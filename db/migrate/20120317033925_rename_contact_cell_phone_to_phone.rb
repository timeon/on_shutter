class RenameContactCellPhoneToPhone < ActiveRecord::Migration
  def self.up
    rename_column :contacts, :adult_1_cell_phone, :adult_1_phone
    rename_column :contacts, :adult_2_cell_phone, :adult_2_phone
    add_column :contacts, :adult_1_phone_ext, :integer
    add_column :contacts, :adult_2_phone_ext, :integer
  end

  def self.down
    rename_column :contacts, :adult_2_phone, :adult_2_cell_phone
    rename_column :contacts, :adult_1_phone, :adult_1_cell_phone
    remove_column :contacts, :adult_2_phone_ext
    remove_column :contacts, :adult_1_phone_ext
  end
end
