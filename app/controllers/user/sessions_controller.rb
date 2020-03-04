class User::SessionsController < User::Base
  skip_before_action :authorize

  def new
    if current_user
      redirect_to :user_root
    else
      @form = User::LoginForm.new
      render action: "new"
    end
  end

  def create
    @form = User::LoginForm.new(login_form_params)
    if @form.email.present?
      user = User.find_by("LOWER(email) = ?", @form.email.downcase)
    end
    if User::Authenticator.new(user).authenticate(@form.password)
      session[:user_id] = user.id
      session[:last_access_time] = Time.current
      flash.notice = "ログインしました。"
      redirect_to :user_root
    else
      flash.now.alert = "メールアドレスまたはパスワードが正しくありません。"
      render action: "new"
    end
  end
  
  # ログアウト
  def destroy
    session.delete(:user_id)
    flash.notice = "ログアウトしました。"
    redirect_to :user_login
  end

  private 
  
  def login_form_params
    params.require(:user_login_form).permit(:email, :password)
  end
end