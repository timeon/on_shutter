class RenamePhoneToHomePhone< ActiveRecord::Migration
  def self.up
    rename_column :contacts, :phone_number, :home_phone
  end

  def self.down
    rename_column :contacts, :home_phone, :phone_number
  end
end
