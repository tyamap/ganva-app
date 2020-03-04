class User::Authenticator
  def initialize(user)
    @user = user
  end

  # ユーザ認証
  def authenticate(raw_password)
    @user&.hashed_password &&
      BCrypt::Password.new(@user.hashed_password) == raw_password
  end
end
