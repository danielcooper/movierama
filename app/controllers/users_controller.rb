class UsersController < ApplicationController

  def show
    authorize! :read, User
  end

  def update
    authorize! :update, User
    #TODO: Move this out into a user update service?
    if params[:notify_me]
      current_user.update notify_me: true
    else
      current_user.update notify_me: false
    end
    redirect_to user_path, notice: "Preferences updated"

  end




end
