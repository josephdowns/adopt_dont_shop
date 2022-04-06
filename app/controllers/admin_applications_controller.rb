class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    if @application.application_pets.map {|ap| ap.approved }.all?(true)
      @application.update(status: "Approved")
      @application.pets.each {|pet| pet.update(adoptable: false) }
    elsif @application.application_pets.map {|ap| ap.approved }.any?(false) && @application.application_pets.map {|ap| ap.approved }.any?(!nil)
      @application.update(status: "Rejected")
    end
  end
end
