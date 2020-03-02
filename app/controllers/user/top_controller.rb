class User::TopController < User::Base
  def index
    render action: 'index'
  end
end
