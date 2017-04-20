class JoinsController < ApplicationController
  # joins an event
  def create
    Join.create(event_id: params[:event], user: current_user)
    redirect_to "/events"
  end

  # cancels an event the user has joined
  def destroy
    @join = Join.find(params[:id])
    if current_user == @join.user
      @join.destroy
    end
    redirect_to "/events"
  end
end
