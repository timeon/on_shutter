class DeletePhoneTypeFromContact < ActiveRecord::Migration
  def self.up
    remove_column :contacts, :phone_type
  end

  def self.down
    add_column :contacts, :phone_type, :string
  end
end
