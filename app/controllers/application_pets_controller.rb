class ApplicationPetsController < ApplicationController
  def create

  end

  def update
    binding.pry
    application = Application.find(params[:id])
    application_pet = Pet.find(params[:pet_id]).application_pets.find {|ap| ap.application_id == application.id }
    application_pet.update(approved: params[:approved])
    redirect_to "/admin/applications/#{application.id}"
  end
end
