class User::SessionsController < User::Base
  def new
    if current_user
      redirect_to :user_root
    else
      @form = User::LoginForm.new
      render action: "new"
    end
  end
end
