class User::ActivitiesController < User::Base
  def index
    @user = if params[:user_id]
              User.find(params[:user_id])
            else
              current_user
            end
    @activities = @user.activities
  end

  def show
    @activity = Activity.find(params[:id])
    @gym = Gym.find(@activity.gym_id)
  end

  def new_commit
    @title = '宣言の追加'
    @is_commit = true
    @activity = Activity.new(flash[:activity])
    @gyms = Gym.all
    render action: 'new'
  end

  def new_result
    @title = '結果の追加'
    @is_commit = false
    @activity = Activity.new(flash[:activity])
    @activity.build_level_count
    @gyms = Gym.all
    render action: 'new'
  end

  def create
    activity = current_user.activities.new(activity_params)
    activity.build_level_count
    if params[:activity][:level_count]
      activity.level_count.assign_attributes(level_count_params)
      activity.status = 'recorded'
    else
      activity.level_count.mark_for_destruction
    end

    if activity.save!
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
    flash.notice = 'アクティビティを削除しました。'
    redirect_to :user_activities
  end

  private

  def activity_params
    params.require(:activity).permit(
      :date, :start_time, :end_time, :gym_id, :level, :description
    )
  end

  def level_count_params
    params.require(:activity).require(:level_count).permit(
      :level0, :level1, :level2, :level3, :level4,
      :level5, :level6, :level7, :level8, :level9
    )
  end
end
