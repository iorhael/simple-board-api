# frozen_string_literal: true

class CreateRefreshTokens < ActiveRecord::Migration[7.1]
  def change
    create_table :refresh_tokens do |t|
      t.string :jti,             limit: 36
      t.datetime :expires_at,    null: false
      t.boolean :is_revoked,     null: false, default: false
      t.boolean :is_blacklisted, null: false, default: false

      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end

    add_index :refresh_tokens, :jti, unique: true
  end
end
