class UsersController < ApplicationController
  skip_before_action :require_login, except: [:show, :edit, :update, :destroy]
  before_action :require_id_match, except: [:index, :new, :create]

  # registers new user account
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to "/events"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/sessions/new"
    end
  end

  # displays page that allows user to update personal info
  def edit
    @user = User.find(params[:id])
    @states = ['AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN',
              'IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV',
              'NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN',
              'TX','UT','VT','VA','WA','WV','WI','WY']
  end

  # updates user info
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      redirect_to "/events"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/users/#{@user.id}/edit"
    end
  end

  # deletes user account
  def destroy
    User.find(params[:id]).destroy
    session[:user_id] = nil
    redirect_to "/sessions/new"
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :city, :state, :password, :password_confirmation)
    end

    def require_id_match
      if current_user != User.find(params[:id])
        redirect_to "/events"
      end
    end
end
