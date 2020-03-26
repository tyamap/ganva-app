class User::ActivitiesController < User::Base
  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @activities = @user.name + 'さんのアクティビティ'
    else
      @user = current_user
      @activities = 'あなたのアクティビティ'
    end
  end

  def show
    @activity   = Activity.find(params[:id])
    @commit     = @activity.commit_record
    @commit_gym = Gym.find(@commit.gym_id)
    @result     = @activity.result_record
    @result_gym = Gym.find(@result.gym_id)
  end

  def new; end

  def edit; end
end
