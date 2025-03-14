require 'rails_helper'

RSpec.describe "admin applications show", type: :feature do
before :each do
  @shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
  @scooby = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
  @scrappy = Pet.create!(name: "Scrappy", age: 3, breed: 'Pug', adoptable: true, shelter_id: @shelter.id)
  @application = Application.create!(status: "In Progress", name: "Murmuring Savannah", street: '123 Main',city: 'Leadville', state: 'CO',
    zip: 11111, description: "I have an acre of grass.")
  @application_2 = Application.create!(status: "In Progress", name: "Willy", street: '555 Circle Dr',city: 'Phoenix', state: 'AZ',
    zip: 22222, description: "")
end
    describe "when I visit admin applications show page" do
    it "approves a pet for adoption" do
      visit "/applications/#{@application.id}"
      fill_in("search", with: "Scooby")
      click_on "Search"
      click_button "Adopt #{@scooby.name}"
      fill_in("search", with: "Scrappy")
      click_on "Search"
      click_button "Adopt #{@scrappy.name}"
      visit "/admin/applications/#{@application.id}"
      expect(page).to have_no_content("Pet Approved")
      click_button "Approve Application for Scooby"
      expect(current_path).to eq("/admin/applications/#{@application.id}")
      expect(page).to have_button("Approve Application for Scrappy")
      expect(page).to have_no_button("Approve Application for Scooby")
      expect(page).to have_content("Pet Approved")
    end

    it "denies a pet for adoption" do
      visit "/applications/#{@application.id}"
      fill_in("search", with: "Scooby")
      click_on "Search"
      click_button "Adopt #{@scooby.name}"
      fill_in("search", with: "Scrappy")
      click_on "Search"
      click_button "Adopt #{@scrappy.name}"
      visit "/admin/applications/#{@application.id}"
      expect(page).to have_no_content("Pet Approved")
      click_button "Reject Application for Scooby"
      # save_and_open_page
      expect(current_path).to eq("/admin/applications/#{@application.id}")
      expect(page).to have_button("Approve Application for Scrappy")
      expect(page).to have_no_button("Approve Application for Scooby")
      expect(page).to have_content("Pet Rejected")
      expect(page).to have_no_content("Pet Approved")
    end

    it "approving/rejecting a pet on one application has no effect on other applications" do
      visit "/applications/#{@application.id}"

      fill_in("search", with: "Scooby")
      click_on "Search"
      click_button "Adopt #{@scooby.name}"

      fill_in("search", with: "Scrappy")
      click_on "Search"
      click_button "Adopt #{@scrappy.name}"

      visit "/admin/applications/#{@application.id}"
      click_button "Reject Application for Scooby"

      visit "/applications/#{@application_2.id}"
      fill_in("search", with: "Scooby")
      click_on "Search"
      click_button "Adopt #{@scooby.name}"

      visit "/admin/applications/#{@application_2.id}"
      expect(page).to have_no_content("Pet Rejected")
    end

    it 'approves application if all pets are approved' do
      visit "/applications/#{@application.id}"

      fill_in("search", with: "Scooby")
      click_on "Search"
      click_button "Adopt #{@scooby.name}"

      fill_in("search", with: "Scrappy")
      click_on "Search"
      click_button "Adopt #{@scrappy.name}"

      visit "/admin/applications/#{@application.id}"
      click_button "Approve Application for Scooby"
      expect(page).to have_no_content("Application Approved")
      click_button "Approve Application for Scrappy"
      expect(page).to have_content("Application Approved")
    end

    it 'rejects application if one or more pets are rejected' do
      visit "/applications/#{@application.id}"

      fill_in("search", with: "Scooby")
      click_on "Search"
      click_button "Adopt #{@scooby.name}"

      fill_in("search", with: "Scrappy")
      click_on "Search"
      click_button "Adopt #{@scrappy.name}"

      visit "/admin/applications/#{@application.id}"
      click_button "Reject Application for Scooby"
      expect(page).to have_no_content("Application Rejected")
      click_button "Approve Application for Scrappy"
      expect(page).to have_content("Application Rejected")
    end

    it 'application approval makes pets not adoptable' do
      visit "/applications/#{@application.id}"

      fill_in("search", with: "Scooby")
      click_on "Search"
      click_button "Adopt #{@scooby.name}"

      fill_in("search", with: "Scrappy")
      click_on "Search"
      click_button "Adopt #{@scrappy.name}"

      visit "/admin/applications/#{@application.id}"
      click_button "Approve Application for Scooby"
      expect(page).to have_no_content("Application Approved")
      click_button "Approve Application for Scrappy"

      visit "/pets/#{@scooby.id}"
      expect(page).to have_content("Adoptable? false")

      visit "/pets/#{@scrappy.id}"
      expect(page).to have_content("Adoptable? false")
    end

    it 'pets can only have one approved application on them at any time' do
      visit "/applications/#{@application.id}"

      fill_in("search", with: "Scooby")
      click_on "Search"
      click_button "Adopt #{@scooby.name}"
      fill_in(:description, with: "I like dogs")
      click_button "Submit my application"

      visit "/applications/#{@application_2.id}"

      fill_in("search", with: "Scooby")
      click_on "Search"
      click_button "Adopt #{@scooby.name}"
      fill_in(:description, with: "I'm a great guy!")
      click_button "Submit my application"

      visit "/admin/applications/#{@application.id}"
      click_button "Approve Application for Scooby"

      visit "/admin/applications/#{@application_2.id}"
      
      expect(page).to have_no_button("Approve Application for Scooby")
      expect(page).to have_content("Pet has been approved for adoption")
      expect(page).to have_button("Reject Application for Scooby")
    end
  end

end
