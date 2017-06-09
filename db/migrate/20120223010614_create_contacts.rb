class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :adult_1_first_name
      t.string :adult_1_last_name
      t.string :adult_1_chinese_name
      t.string :adult_1_email
      t.string :adult_2_first_name
      t.string :adult_2_last_name
      t.string :adult_2_chinese_name
      t.string :adult_2_email
      t.string :phone_number
      t.string :phone_type
      t.string :street_no_and_name
      t.string :city
      t.string :zip
      t.string :child_1_first_name
      t.string :child_2_first_name
      t.string :child_3_first_name
      t.string :child_4_first_name
      t.string :child_5_first_name

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
