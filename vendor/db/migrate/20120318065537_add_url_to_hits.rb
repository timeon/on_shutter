class AddUrlToHits < ActiveRecord::Migration
  def self.up
    add_column :hits, :url, :string
  end

  def self.down
    remove_column :hits, :url
  end
end
