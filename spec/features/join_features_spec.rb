require 'rails_helper'

feature "Join features" do
  before do
    @user = create(:user)
    @user2 = create(:user, email: "newuser@gmail.com")
    @event = create(:event, user: @user2)
    log_in
  end

  feature "event has not been joined" do
    before(:each) do
      visit "/events"
    end
    scenario "Join button is visible" do
      expect(page).to have_button("Join")
    end
  end

  feature "event has been joined" do
    before do
      @join = create(:join, user: @user, event: @event)
    end
    before(:each) do
      visit "/events"
    end
    scenario "Cancel button is visible" do
      expect(page).to have_text("Joining")
      expect(page).to have_button("Cancel")
    end
    scenario "clicking Cancel button will replace with Join button" do
      click_button "Cancel"
      expect(page).not_to have_button("Cancel")
      expect(page).to have_button("Join")
    end
  end
end
