class User::TopController < User::Base
  skip_before_action :authorize

  def index
    if current_user.nil?
      render action: 'index'
    else
      redirect_to :user_home
    end
  end
end
