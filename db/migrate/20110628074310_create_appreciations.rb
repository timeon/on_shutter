class CreateAppreciations < ActiveRecord::Migration
  def self.up
    create_table :appreciations do |t|
      t.references :user
      t.references :photo
      t.references :question
      t.references :article

      t.timestamps
    end
  
    add_index :appreciations, :user_id
    add_index :appreciations, :photo_id
    add_index :appreciations, :question_id
    add_index :appreciations, :article_id

  end

  def self.down
    drop_table :appreciations
  end
end
