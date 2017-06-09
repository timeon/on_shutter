class AddPhotoNumberToContact < ActiveRecord::Migration
  def self.up
    add_column :contacts, :photo_number, :integer
  end

  def self.down
    remove_column :contacts, :phoeo_number
  end
end
