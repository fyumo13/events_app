require 'rails_helper'

RSpec.describe JoinsController, type: :controller do
  before do
    @user = create(:user)
    @event = create(:event, user: @user)
    @join = create(:join, event: @event, user: @user)
  end
  context "when not logged in" do
    before do
      session[:user_id] = nil
    end
    it "cannot create a join" do
      post :create
      expect(response).to redirect_to("/sessions/new")
    end
    it "cannot destroy a join" do
      delete :destroy, id: @event
      expect(response).to_not be_success
    end
  end

  before do
    @user2 = create(:user, email: "newuser@gmail.com")
  end
  context "when signed in as the wrong user" do
    before do
      session[:user_id] = @user2.id
    end
    it "should not be able to destroy a join" do
      delete :destroy, id: @join
      expect(response).to_not be_success
    end
  end
end
