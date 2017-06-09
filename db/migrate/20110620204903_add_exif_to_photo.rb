class AddExifToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :taken_at, :datetime
    add_column :photos, :date_digitized, :datetime
    add_column :photos, :date_original, :datetime
    add_column :photos, :make, :string
    add_column :photos, :model, :string
    add_column :photos, :width, :integer
    add_column :photos, :height, :integer
    add_column :photos, :f_number, :string
    add_column :photos, :focal_length, :string
    add_column :photos, :exposure_time, :string
    add_column :photos, :iso, :integer
    add_column :photos, :flash, :integer
    add_column :photos, :white_balance, :integer
    add_column :photos, :exposure_program, :integer
    add_column :photos, :exposure_bias_value, :string
    add_column :photos, :metering_mode, :integer


  end

  def self.down
    remove_column :photos, :taken_at
    remove_column :photos, :date_digitized
    remove_column :photos, :date_original
    remove_column :photos, :make
    remove_column :photos, :model
    remove_column :photos, :width
    remove_column :photos, :height
    remove_column :photos, :f_number
    remove_column :photos, :focal_length
    remove_column :photos, :exposure_time
    remove_column :photos, :iso
    remove_column :photos, :flash
    remove_column :photos, :white_balance
    remove_column :photos, :exposure_program
    remove_column :photos, :exposure_bias_value
    remove_column :photos, :metering_mode

  end
end

