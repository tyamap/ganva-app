class User::ActivitiesController < User::Base
  def index
      @user = User.find(params[:user_id])
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
