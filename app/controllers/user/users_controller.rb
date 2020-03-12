class User::UsersController < User::Base
  skip_before_action :authorize, only: %i[new create]

  def home
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
  end

  def index; end

  def new
    @new_user = User.new
  end

  def create
    @new_user = User.new(user_params)
    if @new_user.save
      flash.notice = 'アカウントを新規登録しました。'
      redirect_to :user_login
    else
      render action: 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :name, :uid,
                                 :experience, :frequency, :level, :introduction)
  end
end
