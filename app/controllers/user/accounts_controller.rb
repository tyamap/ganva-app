class User::AccountsController < User::Base
  def show
    @current_user = current_user
  end
end
