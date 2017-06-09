class CreateHits < ActiveRecord::Migration
  def self.up
    create_table :hits do |t|
      t.references :referrer_url
      t.string :ip
      t.string :host
      t.string :browser_name
      t.string :browser_version
      t.string :browser_platform

      t.timestamps
    end

    add_index :hits, :referrer_url_id
  end

  def self.down
    drop_table :hits
  end
end
