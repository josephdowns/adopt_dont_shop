require 'rails_helper'

RSpec.describe "admin applications show", type: :feature do
before :each do
  @shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
  @scooby = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
  @scrappy = Pet.create!(name: "Scrappy", age: 3, breed: 'Pug', adoptable: true, shelter_id: @shelter.id)
  @application = Application.create!(status: "In Progress", name: "Murmuring Savannah", street: '123 Main',city: 'Leadville', state: 'CO',
    zip: 11111, description: "")
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
      expect(page).to have_no_content("Application Approved")
      click_button "Approve Application for Scooby"
      expect(current_path).to eq("/admin/applications/#{@application.id}")
      expect(page).to have_button("Approve Application for Scrappy")
      expect(page).to have_no_button("Approve Application for Scooby")
      expect(page).to have_content("Application Approved")
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
      expect(page).to have_no_content("Application Approved")
      click_button "Reject Application for Scooby"
      # save_and_open_page
      expect(current_path).to eq("/admin/applications/#{@application.id}")
      expect(page).to have_button("Approve Application for Scrappy")
      expect(page).to have_no_button("Approve Application for Scooby")
      expect(page).to have_content("Application Rejected")
      expect(page).to have_no_content("Application Approved")
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
      expect(page).to have_no_content("Application Rejected")

    end
  end

end
