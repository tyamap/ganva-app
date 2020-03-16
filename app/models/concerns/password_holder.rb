module PasswordHolder
  extend ActiveSupport::Concern

  included do
    
    validates :password, length: { minimum: 6 }
  end
end
