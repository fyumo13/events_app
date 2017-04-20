class EventsController < ApplicationController
  # displays events dashboard
  def index
    @user = User.find(session[:user_id])
    @events = Event.all
    @states = ['AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN',
              'IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV',
              'NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN',
              'TX','UT','VT','VA','WA','WV','WI','WY']
  end

  # creates a new event
  def create
    @event = Event.new(event_params)
    if !@event.save
      flash[:errors] = @event.errors.full_messages
    end
    redirect_to "/events"
  end

  # displays page containing info specific to a particular event
  def show
    @event = Event.find(params[:id])
    @attendees = @event.users
    @comments = Comment.where(event: @event)
  end

  # displays a page that allows user to update event info
  def edit
    @event = Event.find(params[:id])
    @states = ['AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN',
              'IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV',
              'NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN',
              'TX','UT','VT','VA','WA','WV','WI','WY']
  end

  # updates information specific to an event
  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    if @event.save
      redirect_to "/events/#{@event.id}"
    else
      flash[:errors] = @event.errors.full_messages
      redirect_to "/events/#{@event.id}/edit"
    end
  end

  # deletes an event
  def destroy
    @event = Event.find(params[:id])
    if current_user == @event.user
      @event.destroy
    end
    redirect_to "/events"
  end

  private
    def event_params
      params.require(:event).permit(:name, :date, :city, :state).merge(user: current_user)
    end
end
