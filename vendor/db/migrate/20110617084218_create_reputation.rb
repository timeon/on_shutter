class CreateReputation < ActiveRecord::Migration
  def self.up
    create_table :reputations do |t|
      t.integer :points
      t.string  :reason
      t.references :user
      t.references :photo
      t.references :critique
      t.timestamps
    end

    add_index :reputations, :user_id
    add_index :reputations, :photo_id
    add_index :reputations, :critique_id
  end

  def self.down
    drop_table :reputations
  end
end
