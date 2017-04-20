require 'rails_helper'

feature "Event features" do
  before do
    @user = create(:user)
    @user2 = create(:user, email: "newuser@gmail.com")
    log_in
    @event = create(:event, user: @user)
    @event2 = create(:event, name: "Test", state: "CA", user: @user2)
  end

  feature "Events Dashboard" do
    before(:each) do
      visit "/events"
    end
    scenario "displays all events" do
      expect(page).to have_text(@event.name)
      expect(page).to have_text(@event2.name)
    end
    scenario "create a new event" do
      fill_in "event[name]", with: "New Event"
      fill_in "event[date]", with: "07/04/2017"
      fill_in "event[city]", with: "Seattle"
      select "WA", from: "event[state]"
      click_button "Add Event"
      expect(current_path).to eq("/events")
      expect(page).to have_text("New Event")
    end
    scenario "clicking Edit button leads to Edit Event page" do
      click_link "Edit"
      expect(current_path).to eq("/events/#{@event.id}/edit")
    end
    scenario "destroy an event" do
      click_link "Delete"
      expect(current_path).to eq("/events")
      expect(page).not_to have_text(@event.name)
    end
  end

  feature "Events show page" do
    before do
      @join = create(:join, user: @user2, event: @event)
    end
    before(:each) do
      visit "events/#{@event.id}"
    end
    scenario "displays correct information" do
      expect(page).to have_text(@event.name)
      expect(page).to have_text(@event.user.first_name)
      expect(page).to have_text(@event.user.last_name)
      expect(page).to have_text(@event.city)
      expect(page).to have_text(@event.state)
    end
    scenario "displays correct count of attendees" do
      expect(page).to have_text("People who are joining this event: 1")
    end
    scenario "displays attendees of event" do
      expect(page).to have_text(@user2.first_name)
      expect(page).to have_text(@user2.last_name)
      expect(page).to have_text(@user2.city)
      expect(page).to have_text(@user2.state)
    end
    scenario "submit a comment about event" do
      fill_in "content", with: "This is my comment."
      click_button "Submit Comment"
      expect(current_path).to eq("/events/#{@event.id}")
      expect(page).to have_text("This is my comment.")
    end
  end

  feature "Edit Event page" do
    before(:each) do
      visit "/events/#{@event.id}/edit"
    end
    scenario "visit event's edit page" do
      expect(page).to have_field("event[name]")
      expect(page).to have_field("event[date]")
      expect(page).to have_field("event[city]")
      expect(page).to have_field("event[state]")
    end
    scenario "incorrectly updates information" do
      click_button "Update Event"
      expect(current_path).to eq("/events/#{@event.id}/edit")
      page.has_content?("can't be blank")
    end
    scenario "correctly updates information" do
      fill_in "event[name]", with: "Birthday Party"
      fill_in "event[date]", with: "08/10/2017"
      fill_in "event[city]", with: "Seattle"
      select "WA", from: "event[state]"
      click_button "Update Event"
      expect(current_path).to eq("/events/#{@event.id}")
    end
  end
end
