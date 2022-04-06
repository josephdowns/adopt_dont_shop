# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ApplicationPet.destroy_all
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all

shelter1 = Shelter.create(name: "Pets Are Us", street: "345 First St", city: "Narshe, WOB", zip: 98765, foster_program: true , rank: 3)
shelter2 = Shelter.create(name: 'Aurora shelter', street: "500 Second St", city: 'Aurora, CO', zip: 98765, foster_program: false, rank: 9)
shelter3 = Shelter.create(name: 'RGV animal shelter', street: "304 Third St", city: 'Harlingen, TX', zip: 98875, foster_program: false, rank: 5)
shelter4 = Shelter.create(name: 'Fancy pets of Colorado', street: "4675 Fourth St", city: 'Denver, CO', zip: 98765, foster_program: true, rank: 10)

shelter1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
shelter1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
shelter1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)

shelter2.pets.create(name: 'Rascal', breed: 'lab', age: 4, adoptable: true)
shelter2.pets.create(name: 'Tinker', breed: 'mutt', age: 1, adoptable: true)
shelter2.pets.create(name: 'Rocky', breed: 'terrier', age: 9, adoptable: false)

shelter3.pets.create(name: 'Thor', breed: 'corgi', age: 3, adoptable: true)
shelter3.pets.create(name: 'Loki', breed: 'corgi', age: 3, adoptable: false)
shelter3.pets.create(name: 'Zelda', breed: 'poodle', age: 4, adoptable: true)

shelter4.pets.create(name: 'Link', breed: 'german shepard', age: 4, adoptable: true)
shelter4.pets.create(name: 'Banjo', breed: 'mutt', age: 4, adoptable: true)
shelter4.pets.create(name: 'Lucy', breed: 'sheba', age: 4, adoptable: true)
