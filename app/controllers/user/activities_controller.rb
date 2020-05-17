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
    @activity_form = User::ActivityForm.new(current_user.id)
    @gyms = Gym.all
    @mygym_id = current_user.gym&.id
    render action: 'new'
  end

  def new_result
    @title = '結果の追加'
    @is_commit = false
    @activity_form = User::ActivityForm.new(current_user.id)
    @activity_form.activity.build_level_count
    @gyms = Gym.all
    @mygym_id = current_user.gym&.id
    render action: 'new'
  end

  def create
    @activity_form = User::ActivityForm.new(current_user.id)
    @activity_form.assign_attributes(params)

    if @activity_form.save
      flash.notice = 'アクティビティを追加しました。'
      redirect_to action: 'index'
    else
      flash.alert = @activity_form.activity.errors.full_messages.join('　')
      if params[:activity][:level_count]
        redirect_back fallback_location: :result_new_user_activities, flash: { activity: @activity_form.activity }
      else
        redirect_back fallback_location: :commit_new_user_activities, flash: { activity: @activity_form.activity }
      end
    end
  end

  def edit
    @activity_form = User::ActivityForm.new(current_user.id, Activity.find(params[:id]))
    @is_commit = @activity_form.activity.status != Settings.activity.status.recorded
    @gyms = Gym.all
    @mygym_id = current_user.gym&.id
    render action: 'edit'
  end

  def update
    @activity_form = User::ActivityForm.new(current_user.id, Activity.find(params[:id]))
    @activity_form.assign_attributes(params)

    if @activity_form.save
      flash.notice = 'アクティビティを更新しました。'
      redirect_to action: 'index'
    else
      flash.alert = @activity_form.activity.errors.full_messages.join('　')
      redirect_to [:edit, :user, @activity_form.activity]
    end
  end

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
