class User::Base < ApplicationController
  before_action :authorize

  private

  # ユーザログインのセッション情報
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  helper_method :current_user

  # セッションによるフィルタリング
  def authorize
    unless current_user
      flash.alert = "ログインしてください。"
      redirect_to :user_login
    end
  end

  TIMEOUT = 60.minutes
  # セッションタイムアウトの設定
  def check_timeout
    if current_user
      if session[:last_access_time] >= TIMEOUT.ago
        session[:last_access_time] = Time.current
      else
        session.delete(:user_id)
        flash.alert = "セッションがタイムアウトしました。"
        redirect_to :user_login
      end
    end
  end
end