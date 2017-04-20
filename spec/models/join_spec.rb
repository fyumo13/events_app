require 'rails_helper'

RSpec.describe Join, type: :model do
  context "relationships" do
    before do
      @user = create(:user)
      @event = create(:event, user: @user)
      @join = create(:join, user: @user, event: @event)
    end
    it "belongs to a user" do
      expect(@join.user).to eq(@user)
    end
    it "belongs to an event" do
      expect(@join.event).to eq(@event)
    end
  end
end
