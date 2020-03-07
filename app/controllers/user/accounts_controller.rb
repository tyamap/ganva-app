class User::AccountsController < User::Base
  def new
  end

  def create
  end

  def home
    @current_user = current_user
    render action: 'home'
  end

  def show
    uid = params[:uid]
    @show_user = User.find_by(uid: uid)
    render action: 'show_user'
  end
end
