class User::ActivityForm
  include ActiveModel::Model

  attr_accessor :activity, :user_id
  delegate :persisted?, :save, :save!, to: :activity

  def initialize(user, activity = nil)
    @activity = activity
    @activity ||= Activity.new
    self.user_id = user.id
    # self.inputs_commit_record = @activity.commit_record.present?
    # self.inputs_result_record = @activity.result_record.present?
    # @activity.build_commit_record unless @activity.commit_record
    # @activity.build_result_record unless @activity.result_record
    # @activity.result_record.build_level_count
  end

  def assign_attributes(params = {})
    @params = params
    # self.inputs_commit_record = params[:inputs_commit_record] == "1"
    # self.inputs_result_record = params[:inputs_result_record] == "1"

    activity.assign_attributes(activity_params)

    # if inputs_commit_record
    #   activity.commit_record.assign_attributes(commit_record_params)
    # else
    #   activity.commit_record.mark_for_destruction
    # end
    # if inputs_result_record
    #   activity.result_record.assign_attributes(result_record_params)
    #   level_count = level_count_params(:result_record).fetch(:level_count)
    # else
    #   activity.result_record.mark_for_destruction
    # end
  end

  private

  def activity_params
    @params.require(:activity).permit(
      :date, :description, :start_time, :end_time, :gym_id
    ).merge(user_id: user_id)
  end

  # def commit_record_params
  #   @params.require(:commit_record).permit(
  #     :start_time, :end_time, :gym_id, :level,
  #   )
  # end

  # def result_record_params
  #   @params.require(:result_record).permit(
  #     :start_time, :end_time, :gym_id, :level,
  #   )
  # end

  # def level_count_params(record_name)
  #   @params.require(record_name).permit(
  #     :level0, :level1, :level2, :level3, :level4,
  #     :level5, :level6, :level7, :level8, :level9,
  #   )
  # end
end
