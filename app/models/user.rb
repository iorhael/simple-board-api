# frozen_string_literal: true

class User < ApplicationRecord
  enum notification_method: {
    email: 0,
    telegram: 1
  }

  has_secure_password

  validates :email, :name, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
