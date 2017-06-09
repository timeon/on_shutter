class AddTestimonyToAppreciation < ActiveRecord::Migration
  def self.up
    add_column :appreciations, :testimony_id, :integer
    add_index :appreciations, :testimony_id
  end

  def self.down
    remove_column :appreciations, :testimony_id
  end
end
