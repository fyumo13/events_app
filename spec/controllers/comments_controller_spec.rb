require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before do
    @user = create(:user)
    @event = create(:event, user: @user)
    @join = create(:join, event: @event, user: @user)
  end
  context "when not logged in" do
    before do
      session[:user_id] = nil
    end
    it "cannot create a comment" do
      post :create, id: @event
      expect(response).to redirect_to("/sessions/new")
    end
  end
end
