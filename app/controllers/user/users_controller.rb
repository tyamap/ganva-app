class User::UsersController < User::Base
  skip_before_action :authorize, only: [:new, :create]

  def show
    uid = params[:uid]
    @show_user = User.find_by(uid: uid)
  end

  def new
  end

  def create
  end
end
