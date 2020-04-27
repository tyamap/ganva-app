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
    @gyms = Gym.all
    render action: 'new'
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
    flash.notice = 'アクティビティを削除しました。'
    redirect_to :user_activities
  end
end
