class User::ActivityForm
  include ActiveModel::Model

  attr_accessor :activity, :user_id
  delegate :persisted?, :save, :save!, to: :activity

  def initialize(user, activity = nil)
    @activity = activity
    @activity ||= Activity.new
    self.user_id = user.id
    @activity.build_level_count unless @activity.level_count
  end

  def assign_attributes(params = {})
    @params = params

    activity.assign_attributes(activity_params)
    if params[:activity][:level_count]
      activity.level_count.assign_attributes(level_count_params)
      activity.status = 'result'
    else
      activity.level_count.mark_for_destruction
    end
  end

  private

  def activity_params
    @params.require(:activity).permit(
      :date, :start_time, :end_time, :gym_id, :level, :description
    ).merge(user_id: user_id)
  end

  def level_count_params
    @params.require(:level_count).permit(
      :level0, :level1, :level2, :level3, :level4,
      :level5, :level6, :level7, :level8, :level9,
    )
  end
end
