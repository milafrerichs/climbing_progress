class ClimbSessionsController < ApplicationController
  before_action :set_climb_session, only: %i[ show edit update destroy end_session ]

  # GET /climb_sessions or /climb_sessions.json
  def index
    @climb_sessions = current_user.climb_sessions.order(:end)
  end

  # GET /climb_sessions/1 or /climb_sessions/1.json
  def show
  end

  # GET /climb_sessions/new
  def new
    @climb_session = ClimbSession.new
    @locations = Location.all
  end

  # GET /climb_sessions/1/edit
  def edit
    @locations = Location.all
  end

  # POST /climb_sessions or /climb_sessions.json
  def create
    @climb_session = current_user.climb_sessions.build(climb_session_params)
    @climb_session.start = Time.now
    # @climb_session.name = "Session on #{@climb_session.start} at #{@climb_session.location.name}"
    @locations = Location.all

    respond_to do |format|
      if @climb_session.save
        format.html { redirect_to @climb_session, notice: "Climb session was successfully created." }
        format.json { render :show, status: :created, location: @climb_session }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @climb_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /climb_sessions/1 or /climb_sessions/1.json
  def update
    respond_to do |format|
      if @climb_session.update(climb_session_params)
        format.html { redirect_to @climb_session, notice: "Climb session was successfully updated." }
        format.json { render :show, status: :ok, location: @climb_session }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @climb_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /climb_sessions/1 or /climb_sessions/1.json
  def destroy
    @climb_session.destroy!

    respond_to do |format|
      format.html { redirect_to climb_sessions_path, status: :see_other, notice: "Climb session was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def end_session
    # Check if the session has already ended
    if @climb_session.end.present?
      respond_to do |format|
        format.html { redirect_to @climb_session, alert: "Climb session has already ended." }
        format.json { render json: { error: "Session already ended" }, status: :unprocessable_entity }
      end
      return
    end

    if @climb_session.update(end: Time.now)
      respond_to do |format|
        format.html { redirect_to @climb_session, notice: "Climb session ended successfully." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to @clb_session, alert: "Failed to end climb session." }
        format.json { render json: @climb_session.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_climb_session
      @climb_session = ClimbSession.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def climb_session_params
      params.require(:climb_session).permit(:location_id)
    end
end
