class User::ActivitiesController < User::Base
  def index
    if params[:uid]
      uid = params[:uid]
      @show_user = User.find_by(uid: uid)
      @activities = @show_user.name + 'さんのアクティビティ'
    else
      @activities = 'あなたのアクティビティ'
    end
  end

  def show; end

  def new; end

  def edit; end
end
