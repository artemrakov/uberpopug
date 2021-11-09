# frozen_string_literal: true

class SignInForm
  include ActiveFormModel::Virtual

  fields :email, :password

  validates :email, presence: true
  validates :password, presence: true
  validate :account_exists, :account_can_sign_in

  def account_can_sign_in
    errors.add(:password, :cannot_sign_in) if password.present? && !account&.authenticate(password)
  end

  def account_exists
    errors.add(:email, :account_does_not_exist) if email.present? && !account
  end

  def account
    @account ||= Account.find_by(email: email)
  end

  def email=(value)
    @email = value.downcase
  end
end
