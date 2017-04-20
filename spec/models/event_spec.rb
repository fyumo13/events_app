require 'rails_helper'

RSpec.describe Event, type: :model do
  it "requires a name" do
    expect(build(:event, name:'')).to be_invalid
  end
  it "requires a date" do
    expect(build(:event, date:'')).to be_invalid
  end
  it "requires a city" do
    expect(build(:event, city:'')).to be_invalid
  end
  it "requires a state" do
    expect(build(:event, state:'')).to be_invalid
  end

  context "relationships" do
    before do
      @user = create(:user)
      @event = create(:event, user: @user)
    end
    it "belongs to a user" do
      expect(@event.user).to eq(@user)
    end
  end
end
