class User::ActivitiesController < User::Base
  before_action :access_auth, only: %i[edit update abort done ready record]

  def index
    @user = params[:user_id] ? User.find(params[:user_id]) : current_user
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

  def abort
    activity = Activity.find(params[:id])
    return if activity.status != Settings.activity.status.ready

    activity.status = Settings.activity.status.aborted
    if activity.save
      flash.notice = 'アクティビティを中止しました。'
    else
      flash.alert = activity.errors.first[1]
    end
    redirect_to :user_activities
  end

  def done
    activity = Activity.find(params[:id])
    return if activity.status != Settings.activity.status.ready

    activity.status = Settings.activity.status.done
    if activity.save
      flash.notice = 'アクティビティを完了しました。'
    else
      flash.alert = activity.errors.first[1]
    end
    redirect_to :user_activities
  end

  def ready
    activity = Activity.find(params[:id])
    return if activity.status != Settings.activity.status.aborted

    activity.status = Settings.activity.status.ready
    if activity.save
      flash.notice = 'アクティビティを再開しました。'
    else
      flash.alert = activity.errors[:status].first
    end
    redirect_to :user_activities
  end

  def record
    activity = Activity.find(params[:id])
    return redirect_to :user_activities if activity.status != Settings.activity.status.done

    activity.status = Settings.activity.status.recorded
    @activity_form = User::ActivityForm.new(current_user.id, activity)
    render action: 'edit'
  end

  private

  def access_auth
    owner = Activity.find(params[:id]).user
    return if current_user == owner

    flash.alert = '編集権限がありません。'
    redirect_back(fallback_location: :user_home)
  end
end
