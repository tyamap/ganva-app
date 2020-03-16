module PasswordHolder
  extend ActiveSupport::Concern

  validates :password, length: { minimum: 6 }
end
