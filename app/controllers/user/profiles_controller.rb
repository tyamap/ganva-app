class User::ProfilesController < User::Base
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
      flash.notice = "プロフィールを更新しました。"
      redirect_to :user_profile
    else
      render action: "edit"
    end
  end

  private
  
  def user_params
    params.require(:user).permit(
      :name, :experience, :frequency, :level, :introduction
    )
  end
end
