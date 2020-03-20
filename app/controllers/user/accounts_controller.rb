class User::AccountsController < User::Base
  def home
    @user = current_user
  end

  def show
    @user = current_user
  end
end
