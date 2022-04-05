require 'rails_helper'

RSpec.describe "AdminShelters", type: :feature do
  before (:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @rascal = @shelter_3.pets.create(name: "Rascal", age: 3, adoptable: true, breed: "lab")
    @boo = @shelter_3.pets.create(name: "Boo", age: 1, adoptable: true, breed: "lab")
    @tugboat = @shelter_3.pets.create(name: "Tugboat", age: 6, adoptable: true, breed: "lab")
    @raintree = @shelter_3.pets.create(name: "Raintree", age: 5, adoptable: true, breed: "lab")
    @tinker = @shelter_3.pets.create(name: "Tinker", age: 2, adoptable: false, breed: "lab")

    @app1 = Application.create(name: "Joseph" , street: "Humboldt", city: "Denver", state: "CO", zip: 98764, description: "I like dogs" , status: "Pending")
    @app2 = Application.create(name: "Will", street: "Sunburst", city: "Alanta", state: "GA", zip: 76536, description: "I'm cool as a cucumber", status: "Pending")

    ApplicationPet.create(pet_id: @rascal.id, application_id: @app1.id, approved: false)
    ApplicationPet.create(pet_id: @boo.id, application_id: @app1.id, approved: false)
    ApplicationPet.create(pet_id: @raintree.id, application_id: @app2.id, approved: false)
  end

  describe "when I visit a shelters show page as an admin" do
    it "shows a shelter's name and address" do
      visit "/admin/shelters/#{@shelter_1.id}"

      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_1.city)
      expect(page).to_not have_content(@shelter_3.name)
    end


    it "shows a section with statistics" do
      visit "/admin/shelters/#{@shelter_3.id}"

      expect(page).to have_content("Some quick stats about #{@shelter_3.name}:")
    end

    it "shows the average age of adoptable pets at said shelter" do
      visit "/admin/shelters/#{@shelter_3.id}"

      expect(@shelter_3.adoptable_aver_age).to eq(3.75)
      expect(page).to have_content("3.75")
    end

    it "shows the amount of adoptable pets at said shelter" do
      visit "/admin/shelters/#{@shelter_3.id}"

      expect(page).to have_content("4")
    end

    it "shows a section titled action required" do
      visit "/admin/shelters/#{@shelter_3.id}"

      expect(page).to have_content("Action Required")
    end

    it "list the names of all the pets that have pending applications for this shelter" do
      visit "/admin/shelters/#{@shelter_3.id}"

      within('#action') do
        expect(page).to have_content(@rascal.name)
        expect(page).to have_content(@boo.name)
        expect(page).to have_content(@raintree.name)
      end
    end

    it "links me to the application" do
      visit "/admin/shelters/#{@shelter_3.id}"

      within('#action') do
        click_on "#{@rascal.name}"
      end

      expect(current_path).to eq("/admin/applications/#{@app1.id}")
    end
  end
end
