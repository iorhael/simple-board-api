# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email,                null: false
      t.string :password_digest,      null: false
      t.string :name
      t.boolean :is_admin,            null: false, default: false
      t.integer :notification_method, default: 0

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
