class User::ActivitiesController < User::Base
  def index
    if params[:id]
      @user = User.find(params[:id])
      @activities = @user.name + 'さんのアクティビティ'
    else
      @user = current_user
      @activities = 'あなたのアクティビティ'
    end
  end

  def show; end

  def new; end

  def edit; end
end
