class AddRatingToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :rating, :integer, :default => 0
  end
end
