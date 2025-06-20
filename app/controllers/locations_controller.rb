class LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_location, only: %i[ show edit ]

  def index
    @locations = Location.all
  end

  def show
  end

  def new
    @location = Location.new

    session[:add_another] ||= false
  end

  def create
    @location = Location.new(location_params)

    if @location.save
      render json: { success: true }, status: :created
    else
      render json: { errors: @location.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def edit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def location_params
      params.require(:location).permit(:name)
    end
end
