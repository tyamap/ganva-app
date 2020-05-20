class User::ActivitiesController < User::Base
  before_action :access_auth, only: %i[edit update]

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
    @activity_form = User::ActivityForm.new(current_user.id)
    render action: 'new'
  end

  def new_result
    @activity_form = User::ActivityForm.new(current_user.id)
    @activity_form.activity.status = Settings.activity.status.recorded
    render action: 'new'
  end

  def create
    @activity_form = User::ActivityForm.new(current_user.id)
    @activity_form.assign_attributes(params)

    if @activity_form.save
      flash.notice = 'アクティビティを追加しました。'
      redirect_to action: 'index'
    else
      flash.now.alert = '入力に誤りがあります。'
      render action: 'new'
    end
  end

  def edit
    @activity_form = User::ActivityForm.new(current_user.id, Activity.find(params[:id]))
  end

  def update
    @activity_form = User::ActivityForm.new(current_user.id, Activity.find(params[:id]))
    @activity_form.assign_attributes(params)

    if @activity_form.save
      flash.notice = 'アクティビティを更新しました。'
      redirect_to action: 'index'
    else
      flash.now.alert = '入力に誤りがあります。'
      render action: 'edit'
    end
  end

  def destroy
    activity_form = Activity.find(params[:id])
    activity_form.destroy!
    flash.notice = 'アクティビティを削除しました。'
    redirect_to :user_activities
  end

  private

  def access_auth
    owner = Activity.find(params[:id]).user
    return if current_user == owner

    flash.alert = '編集権限がありません。'
    redirect_back(fallback_location: :user_home)
  end

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
