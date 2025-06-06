# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :old_password, :remember_token

  has_secure_password validations: false

  # validates :name, presence: true
  validate :password_presence
  validate :correct_old_password, on: :update, if: -> { password.present? }
  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true, allow_blank: true, length: { minimum: 6, maximum: 20 }

  # validate :password_complexity

  def remember_me
    self.remember_token = SecureRandom.urlsafe_base64
    update_column :remember_token_digest, digest(remember_token)
  end

  def forget_me
    update_column :remember_token_digest, nil
    self.remember_token = nil
  end

  def remember_token_authenticated?(remember_token)
    return false if remember_token_digest.blank?

    BCrypt::Password.new(remember_token_digest).is_password?(remember_token)
  end

  private

  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def correct_old_password
    return if BCrypt::Password.new(password_digest_was).is_password?(old_password)

    errors.add :old_password, 'is incorrect'
  end

  # def password_complexity
  #   # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
  #   return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,20}$/

  #   errors.add :password, "Complexity requirement not met. Length should be 8-20 characters and include: 1 uppercase, 1 lowercase, 1 digit and 1 special character"
  # end

  def password_presence
    errors.add(:password, :blank) if password_digest.blank?
  end
end
