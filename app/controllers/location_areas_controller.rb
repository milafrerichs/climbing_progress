class LocationAreasController < ApplicationController
  before_action :set_location_area, only: %i[ show edit update destroy ]

  # GET /location_areas or /location_areas.json
  def index
    @location_areas = LocationArea.all
  end

  # GET /location_areas/1 or /location_areas/1.json
  def show
  end

  # GET /location_areas/new
  def new
    @location_area = LocationArea.new
  end

  # GET /location_areas/1/edit
  def edit
  end

  # POST /location_areas or /location_areas.json
  def create
    @location_area = LocationArea.new(location_area_params)

    respond_to do |format|
      if @location_area.save
        format.html { redirect_to @location_area, notice: "Location area was successfully created." }
        format.json { render :show, status: :created, location: @location_area }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @location_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /location_areas/1 or /location_areas/1.json
  def update
    respond_to do |format|
      if @location_area.update(location_area_params)
        format.html { redirect_to @location_area, notice: "Location area was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @location_area }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @location_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /location_areas/1 or /location_areas/1.json
  def destroy
    @location_area.destroy!

    respond_to do |format|
      format.html { redirect_to location_areas_path, notice: "Location area was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location_area
      @location_area = LocationArea.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def location_area_params
      params.expect(location_area: [ :name, :location_id ])
    end
end
