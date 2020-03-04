class User::TopController < User::Base
  def index
    @user = current_user
    render action: 'index'
  end
end
