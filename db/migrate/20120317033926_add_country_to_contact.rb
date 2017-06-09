class AddCountryToContact < ActiveRecord::Migration
  def self.up
    add_column :contacts, :country, :string, :default => "US"
  end

  def self.down
    remove_column :contacts, :country
  end
end
