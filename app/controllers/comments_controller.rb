class CommentsController < ApplicationController
  # submits a comment about a particular event
  def create
    @user = User.find(session[:user_id])
    @event = Event.find(params[:id])
    @comment = Comment.new(content: params[:content], user: @user, event: @event)
    if !@comment.save
      flash[:errors] = @comment.errors.full_messages
    end
    redirect_to "/events/#{@event.id}"
  end
end
