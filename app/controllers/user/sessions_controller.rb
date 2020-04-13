class User::SessionsController < User::Base
  skip_before_action :authorize

  def new
    if current_user
      redirect_to :user_home
    else
      @form = User::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = User::LoginForm.new(login_form_params)
    user = User.find_by('LOWER(email) = ?', @form.email.downcase) if @form.email.present?
    if user&.authenticate(@form.password)
      session[:user_id] = user.id
      session[:last_access_time] = Time.current
      flash.notice = 'ログインしました。'
      redirect_to :user_home
    else
      flash.alert = 'メールアドレスまたはパスワードが正しくありません。'
      redirect_back fallback_location: :user_login, flash: { user: user }
    end
  end

  # ログアウト
  def destroy
    session.delete(:user_id)
    flash.notice = 'ログアウトしました。'
    redirect_to :user_login
  end

  private

  def login_form_params
    params.require(:user_login_form).permit(:email, :password)
  end
end
