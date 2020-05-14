class User::UsersController < User::Base
  skip_before_action :authorize, only: %i[new create]
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.name = user_params[:uid]
    if @user.save
      session[:user_id] = @user.id
      session[:last_access_time] = Time.current
      redirect_to :user_home
    else
      render action: 'new'
    end
  end

  def following
    @title = 'Following'
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :uid)
  end
end
