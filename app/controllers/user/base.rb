class User::Base < ApplicationController
  before_action :authorize
  before_action :check_timeout

  helper_method :current_user
  helper_method :current_user?

  private

  # ユーザログインのセッション情報
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # セッションによるフィルタリング
  def authorize
    return if current_user

    flash.alert = 'ログインしてください。'
    redirect_to :user_login
  end

  TIMEOUT = 60.minutes
  # セッションタイムアウトの設定
  def check_timeout
    return unless current_user

    if session[:last_access_time] >= TIMEOUT.ago
      session[:last_access_time] = Time.current
    else
      session.delete(:user_id)
      flash.alert = 'セッションがタイムアウトしました。'
      redirect_to :user_login
    end
  end
end
