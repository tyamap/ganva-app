class User::GymsController < User:Base
  skip_before_action :authorize

  def index
  end

  def show
  end
end
