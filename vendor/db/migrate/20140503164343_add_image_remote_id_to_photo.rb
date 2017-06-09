class AddImageRemoteIdToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :image_remote_id, :string
    add_index  :photos, :image_remote_id
  end
end
