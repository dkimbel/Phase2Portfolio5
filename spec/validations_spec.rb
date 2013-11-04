require "spec_helper"

def create_event_interaction
  page.visit "/events/new"
  page.fill_in "organizer_name", :with => @name
  page.fill_in "organizer_email", :with => @email
  page.fill_in "title", :with => @title
  page.fill_in "date", :with => @date
  page.click_button "Create Event"
end

feature "Event is created for valid inputs" do 
  background do
    @name = Faker::Name.name
    @email = Faker::Internet.email
    @title = Faker::Lorem.words(num = 1)[0]
    @date = "2013-11-15"
  end
  scenario "User enters valid inputs in every field" do
    create_event_interaction
    page.should have_content("#{@name} Invites YOU to #{@title} on #{@date} RSVP to #{@email}")
  end
end

feature "Empty date cannot be used to create event" do 
  background do
    @name = Faker::Name.name
    @email = Faker::Internet.email
    @title = Faker::Lorem.words(num = 1)[0]
    @date = ""
  end
  scenario "User tries to create event with empty date" do
    create_event_interaction
    page.should_not have_content("#{@name} Invites YOU to #{@title} on #{@date} RSVP to #{@email}")
  end
end

feature "Past date cannot be used to create event" do 
  background do
    @name = Faker::Name.name
    @email = Faker::Internet.email
    @title = Faker::Lorem.words(num = 1)[0]
    @date = "2012-11-15"
  end
  scenario "User tries to create event with a past date" do
    create_event_interaction
    page.should_not have_content("#{@name} Invites YOU to #{@title} on #{@date} RSVP to #{@email}")
  end
end

feature "Empty organizer name cannot be used to create event" do
  background do
    @name = ""
    @email = Faker::Internet.email
    @title = Faker::Lorem.words(num = 1)[0]
    @date = "2013-11-15"
  end
  scenario "User tries to create event with empty organizer name" do
    create_event_interaction
    page.should_not have_content("#{@name} Invites YOU to #{@title} on #{@date} RSVP to #{@email}")
  end
end

feature "Empty title cannot be used to create event" do
  background do
    @name = Faker::Name.name
    @email = Faker::Internet.email
    @title = ""
    @date = "2013-11-15"
  end
  scenario "User tries to create event with empty title" do
    create_event_interaction
    page.should_not have_content("#{@name} Invites YOU to #{@title} on #{@date} RSVP to #{@email}")
  end
end

feature "Duplicate title cannot be used to create event" do
  background do
    @name = Faker::Name.name
    @email = Faker::Internet.email
    @title = "Rattlesnake Wrangling and Chicken Shepherding 101"
    @date = "2013-11-15"
    create_event_interaction
    @name = Faker::Name.name
    @email = Faker::Internet.email
    @title = "Rattlesnake Wrangling and Chicken Shepherding 101"
    @date = "2013-11-16"
  end
  scenario "User tries to create event with duplicate title" do
    create_event_interaction
    page.should_not have_content("#{@name} Invites YOU to #{@title} on #{@date} RSVP to #{@email}")
  end
end

feature "Invalid email address cannot be used to create event" do
  background do
    @name = Faker::Name.name
    @email = "lulz_not_an_email_address"
    @title = Faker::Lorem.words(num = 1)[0]
    @date = "2013-11-15"
  end
  scenario "User tries to create event with invalid email address" do
    create_event_interaction
    page.should_not have_content("#{@name} Invites YOU to #{@title} on #{@date} RSVP to #{@email}")
  end
end


