class User::AccountsController < User::Base
  def home
    @user = current_user
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.assign_attributes(user_params)
    if @user.save
      flash.notice = "アカウント情報を更新しました。"
      redirect_to :user_account
    else
      render action: "edit"
    end
  end

  private
  
  def user_params
    params.require(:user).permit(
      :uid, :email
    )
  end
end
