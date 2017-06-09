class CreateEchos < ActiveRecord::Migration
  def self.up
    create_table :echos do |t|
      t.references :user
      t.references :testimony
      t.text       :body
      t.integer    :vote_count

      t.timestamps
    end

    add_index :echos, :user_id
    add_index :echos, :testimony_id
  end

  def self.down
    drop_table :echos
  end
end
