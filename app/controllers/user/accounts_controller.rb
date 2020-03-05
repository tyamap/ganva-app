class User::AccountsController < User::Base
  def show
    uid = params[:uid]
    @show_user = User.find_by(uid: uid)
    render action: 'show_user'
  end
end
