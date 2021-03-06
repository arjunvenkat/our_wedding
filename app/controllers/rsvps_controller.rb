class RsvpsController < ApplicationController
  before_action :set_rsvp, only: [:show, :edit, :update, :destroy]
  before_action :check_if_admin, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  def check_if_admin
    unless current_user && current_user.admin?
      redirect_to root_url, alert: "You're not authorized to go there"
    end
  end

  def household_form
    selected_guest = Guest.find(params[:guest_id])
    @household = Household.find_by(id: selected_guest.household_id )
  end

  # GET /rsvps
  # GET /rsvps.json
  def index
    @rsvps = Rsvp.joins(:guest).order('guests.last').page params[:page]
  end

  # GET /rsvps/1
  # GET /rsvps/1.json
  def show
  end

  # GET /rsvps/new
  def new
    @rsvp = Rsvp.new
  end

  # GET /rsvps/1/edit
  def edit
  end

  # POST /rsvps
  # POST /rsvps.json
  def create
    @rsvp = Rsvp.new(rsvp_params)

    respond_to do |format|
      if @rsvp.save
        format.html { redirect_to @rsvp, notice: 'Rsvp was successfully created.' }
        format.json { render :show, status: :created, location: @rsvp }
      else
        format.html { render :new }
        format.json { render json: @rsvp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rsvps/1
  # PATCH/PUT /rsvps/1.json
  def update
    respond_to do |format|
      if @rsvp.update(rsvp_params)
        format.html { redirect_to @rsvp, notice: 'Rsvp was successfully updated.' }
        format.json { render :show, status: :ok, location: @rsvp }
      else
        format.html { render :edit }
        format.json { render json: @rsvp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rsvps/1
  # DELETE /rsvps/1.json
  def destroy
    @rsvp.destroy
    respond_to do |format|
      format.html { redirect_to rsvps_url, notice: 'Rsvp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rsvp
      @rsvp = Rsvp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rsvp_params
      params.require(:rsvp).permit(:guest_id, :event_id, :status)
    end
end
