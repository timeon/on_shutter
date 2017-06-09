class CreateTestimonies< ActiveRecord::Migration
  def self.up
    create_table :testimonies do |t|
      t.references :user
      t.string     :title
      t.text       :body
      t.integer    :vote_count
      t.integer    :view_count, :default => 0

      t.timestamps
    end

    add_index :testimonies, :user_id

  end

  def self.down
    drop_table :testimonies
  end
end
