class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :check_if_admin, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  def check_if_admin
    unless current_user && current_user.admin?
      redirect_to root_url, alert: "You're not authorized to go there"
    end
  end
  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    if params[:filter]
      if params[:filter] == "attending"
        event_rsvps = @event.replied_rsvps(households: Household.all).attending
      elsif params[:filter] == "not-attending"
        event_rsvps = @event.replied_rsvps(households: Household.all).not_attending
      elsif params[:filter] = "unreplied"
        event_rsvps = @event.unreplied_rsvps(households: Household.all)
      else
        event_rsvps = @event.rsvps
      end
    else
      event_rsvps = @event.rsvps
    end
    @rsvps = event_rsvps.includes(:guest).order('guests.last asc').page params[:page]
    # @guests = @event.guests.order(:last).page params[:page]
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description, :datetime, :address1, :address2, :city, :state, :zip)
    end
end
