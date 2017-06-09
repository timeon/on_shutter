class CreateCritiques < ActiveRecord::Migration
  def self.up
    create_table :critiques do |t|
      t.references :user
      t.references :photo
      t.text       :body
      t.integer    :vote_count

      t.timestamps
    end

    add_index :critiques, :user_id
    add_index :critiques, :photo_id
  end

  def self.down
    drop_table :critiques
  end
end
