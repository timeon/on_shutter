class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.references :user
      t.string     :title
      t.text       :body
      t.integer    :vote_count
      t.integer    :view_count, :default => 0

      t.timestamps
    end

    add_index :articles, :user_id

  end

  def self.down
    drop_table :articles
  end
end
