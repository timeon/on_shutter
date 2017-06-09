class CreateReferrerUrls < ActiveRecord::Migration
  def self.up
    create_table :referrer_urls do |t|
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :referrer_urls
  end
end
