class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.references :user
      t.references :article
      t.text       :body
      t.integer    :vote_count

      t.timestamps
    end

    add_index :reviews, :user_id
    add_index :reviews, :article_id
  end

  def self.down
    drop_table :reviews
  end
end
