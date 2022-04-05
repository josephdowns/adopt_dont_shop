class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    if @application.application_pets.map {|ap| ap.approved }.all?(true)
      @application.update(status: "Approved")
    elsif
      @application.application_pets.map {|ap| ap.approved }.any?(false) && @application.application_pets.map {|ap| ap.approved }.any?(!nil)
        @application.update(status: "Rejected")
    end
  end

  def update
    application = Application.find(params[:id])
    application_pet = Pet.find(params[:pet_id]).application_pets.find {|ap| ap.application_id == application.id }
    application_pet.update(approved: params[:approved])
    redirect_to "/admin/applications/#{application.id}"
  end
end
