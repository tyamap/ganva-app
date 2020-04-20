class User::ActivitiesController < User::Base
  def index
    @user = if params[:user_id]
              User.find(params[:user_id])
            else
              current_user
            end
    @activities = @user.activities
    @activities = @activities.includes(:commit_record, :result_record)
  end

  def show
    @activity   = Activity.find(params[:id])
    @commit     = @activity.commit_record
    @commit_gym = Gym.find(@commit.gym_id) unless @commit.nil?
    @result     = @activity.result_record
    @result_gym = Gym.find(@result.gym_id) unless @result.nil?
  end

  def new
    @activity = Activity.new(flash[:activity])
  end

  def create
    @activity_form = User::ActivityForm.new(current_user)
    @activity_form.assign_attributes(params)
    if @activity_form.save!
      flash.notice = 'アクティビティを追加しました。'
      redirect_to action: 'index'
    else
      flash.alert = '入力に誤りがあります。'
      render action: 'new'
    end
  end

  def edit; end

  def destroy
    activity_form = Activity.find(params[:id])
    activity_form.destroy!
    flash.notice = "アクティビティを削除しました。"
    redirect_to :user_activities
  end
end
