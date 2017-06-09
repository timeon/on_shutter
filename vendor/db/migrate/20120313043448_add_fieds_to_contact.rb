class AddFiedsToContact < ActiveRecord::Migration
  def self.up
    add_column :contacts, :verified, :boolean, :default => false
    add_column :contacts, :disabled, :boolean, :default => false
    add_column :contacts, :child_1_relation, :string, :default => "child"
    add_column :contacts, :child_2_relation, :string, :default => "child"
    add_column :contacts, :child_3_relation, :string, :default => "child"
    add_column :contacts, :child_4_relation, :string, :default => "child"
    add_column :contacts, :child_5_relation, :string, :default => "child"
  end

  def self.down
    remove_column :contacts, :child_5_relation
    remove_column :contacts, :child_4_relation
    remove_column :contacts, :child_3_relation
    remove_column :contacts, :child_2_relation
    remove_column :contacts, :child_1_relation
    remove_column :contacts, :disabled
    remove_column :contacts, :verified
  end
end
