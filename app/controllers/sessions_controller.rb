class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  # displays login/registration page
  def new
    @states = ['AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN',
              'IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV',
              'NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN',
              'TX','UT','VT','VA','WA','WV','WI','WY']
  end

  # logs user in
  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to "/events"
    else
      flash[:errors] = ["Invalid email/password combination."]
      redirect_to "/sessions/new"
    end
  end

  # logs user out
  def destroy
    session[:user_id] = nil
    redirect_to "/sessions/new"
  end
end
