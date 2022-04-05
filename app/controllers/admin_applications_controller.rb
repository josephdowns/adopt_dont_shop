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
    application_pet = ApplicationPet.find(application.application_pets.ids.first)
    application_pet.update(approved: params[:approved])
    redirect_to "/admin/applications/#{application.id}"
  end
end
