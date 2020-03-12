class User::AccountsController < User::Base
  def show
    @user = current_user
  end
end
