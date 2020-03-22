class User::TopController < User::Base
  skip_before_action :authorize, only: %i[index]

  def index
    if current_user.nil?
      render action: 'index'
    else
      redirect_to :user_home
    end
  end

  def home
    @user = current_user
  end
end
