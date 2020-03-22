class User::ChangePasswordForm
  include ActiveModel::Model

  attr_accessor :object, :current_password, :new_password,
                :new_password_confirmation
  validates :new_password, presence: true, confirmation: true

  validate do
    errors.add(:current_password, :wrong) unless object.authenticate(current_password)
  end

  def save
    return unless valid?

    object.password = new_password
    object.save
  end
end
