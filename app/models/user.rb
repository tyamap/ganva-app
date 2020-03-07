class User < ApplicationRecord
  include PasswordHolder

  has_one :profile, dependent: :destroy
end
