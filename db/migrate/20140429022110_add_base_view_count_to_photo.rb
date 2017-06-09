class AddBaseViewCountToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :base_view_count, :integer, :default => 0
  end
end
