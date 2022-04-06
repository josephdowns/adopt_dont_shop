class Application < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :street
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
  validates_presence_of :status

  has_many :application_pets
  has_many :pets, through: :application_pets
end
