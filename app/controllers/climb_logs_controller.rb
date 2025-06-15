class ClimbLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_climb_log, only: %i[ show edit update destroy ]

  def index
    @climb_logs = ClimbLog.all.order(:date).reverse
    @climb_logs_by_date = @climb_logs.group_by { |climb_log| climb_log.date.to_date }
  end

  def show
  end

  def new
    @climb_log = ClimbLog.new
  end

  def edit
  end

  def create
    @climb_log = current_user.climb_logs.build(climb_log_params)

    respond_to do |format|
      if @climb_log.save
        format.html { redirect_to @climb_log, notice: "Climb log was successfully created." }
        format.json { render :show, status: :created, location: @climb_log }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @climb_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @climb_log.update(climb_log_params)
        format.html { redirect_to @climb_log, notice: "Climb log was successfully updated." }
        format.json { render :show, status: :ok, location: @climb_log }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @climb_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @climb_log.destroy!

    respond_to do |format|
      format.html { redirect_to climb_logs_path, status: :see_other, notice: "Climb log was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_climb_log
      @climb_log = ClimbLog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def climb_log_params
      params.require(:climb_log).permit(:date, :location, :route_name, :grade, :status, :tries)
    end
end
