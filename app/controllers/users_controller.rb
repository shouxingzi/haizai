class UsersController < ApplicationController

  def show
    user = User.find(params[:id])
    @tweets = user.tweets
    @rooms = user.rooms
  end

end
