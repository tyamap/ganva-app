class User::PasswordsController < User::Base
  def show
    redirect_to :edit_user_password
  end

  def edit
    @change_password_form = User::ChangePasswordForm.new(object: current_user)
  end

  def update
    @change_password_form = User::ChangePasswordForm.new(user_member_params)
    @change_password_form.object = current_user
    if @change_password_form.save
      flash.notice = "パスワードを変更しました。"
      redirect_to :user_account
    else
      flash.alert = "入力に誤りがあります。"
      render action: "edit"
    end
  end

  private

  def user_member_params
    params.require(:user_change_password_form).permit(
      :current_password, :new_password, :new_password_confirmation
    )
  end
end
