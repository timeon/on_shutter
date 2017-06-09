class AddImageRefererUrlToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :image_referer_url, :string
  end
end
