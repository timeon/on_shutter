class AddOneMoreYearToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :one_more_year, :boolean
  end
end
