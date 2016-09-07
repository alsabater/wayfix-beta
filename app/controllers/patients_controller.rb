class PatientsController < ApplicationController
  respond_to :json, :html

  def index
    @patients = Patient.all

  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

end