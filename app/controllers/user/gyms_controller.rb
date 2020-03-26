class User::GymsController < User::Base
  skip_before_action :authorize

  def index
    @gyms = Gym.all
  end

  def show
    @gym = Gym.find(params[:id])
  end
end
