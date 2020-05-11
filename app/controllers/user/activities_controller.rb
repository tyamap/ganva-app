class User::ActivitiesController < User::Base
  def index
    @user = if params[:user_id]
              User.find(params[:user_id])
            else
              current_user
            end
    @activities = @user.activities.order(date: :desc).includes(:gym)
  end

  def show
    @activity = Activity.find(params[:id])
    @gym = @activity.gym
    return unless @activity.status == Settings.activity.status.recorded

    # 結果レベル情報の取得
    @lc_attr = @activity.level_count.attributes.values[2..11]
    @ln_attr = @gym.level_name.attributes.values[2..11]
  end

  def new_commit
    @title = '宣言の追加'
    @is_commit = true
    @activity = Activity.new(flash[:activity])
    @gyms = Gym.all
    @mygym_id = current_user.gym&.id
    render action: 'new'
  end

  def new_result
    @title = '結果の追加'
    @is_commit = false
    @activity = Activity.new(flash[:activity])
    @activity.build_level_count
    @gyms = Gym.all
    @mygym_id = current_user.gym&.id
    render action: 'new'
  end

  def create
    activity = current_user.activities.new(activity_params)
    activity.build_level_count
    if params[:activity][:level_count]
      activity.level_count.assign_attributes(level_count_params)
      activity.status = Settings.activity.status.recorded
    else
      activity.level_count.mark_for_destruction
    end

    if activity.save
      flash.notice = 'アクティビティを追加しました。'
      redirect_to action: 'index'
    else
      flash.alert = activity.errors.full_messages.join('　')
      if params[:activity][:level_count]
        redirect_back fallback_location: :result_new_user_activities, flash: { activity: activity }
      else
        redirect_back fallback_location: :commit_new_user_activities, flash: { activity: activity }
      end
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
