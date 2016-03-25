class HouseholdsController < ApplicationController
  before_action :set_household, only: [:show, :edit, :update, :destroy, :rsvp_submission, :rsvp_status, :printable_rsvp_status, :check_names, :update_names, :rsvp_form]


  def resend_rsvp
    guest = Guest.find_by_email(params[:email])
    if guest
      html = "<p>We're excited to have you join us at our wedding!</p>"
      html << "<p>Click the link below to RSVP:</p>"
      html << "<p><a href='#{check_names_household_url(guest.household, guest.household.unique_hex)}'>#{check_names_household_url(guest.household, guest.household.unique_hex)}</a></p>"
      html << "<p>Kriti and Arjun</p>"
      text = "Go to the following URL to RSVP to Kriti and Arjun's wedding: #{check_names_household_url(guest.household, guest.household.unique_hex)}"
      client = SendGrid::Client.new(api_key: ENV["sendgrid_api_key"])
      mail = SendGrid::Mail.new do |m|
        m.to = guest.email
        m.from = 'noreply@arjunandkriti.com'
        m.subject = "RSVP for Kriti and Arjun's wedding"
        m.text = text
        m.html = html
      end
      res = client.send(mail)
      puts res.inspect

      redirect_to root_url, notice: "The RSVP email was resent to #{params[:email]}"
    else
      redirect_to root_url, alert: "We couldn't find your email address. Please make sure you entered it correctly or contact Arjun at avenkat2@gmail.com for assistance"
    end
  end

  def route_rsvp
    selected_guest = Guest.find_by(id: params[:guest_id])
    if selected_guest
      household = Household.find_by(id: selected_guest.household_id )
      if current_household && current_household.guests.include?(selected_guest)
        redirect_to rsvp_status_household_path(current_household, current_household.unique_hex)
      else
        redirect_to check_names_household_path(household.id, household.unique_hex)
      end
    else
      redirect_to root_url, alert: 'Please submit a valid name for your RSVP'
    end
  end

  def check_names
    render layout: 'home_layout'
  end

  def update_names
    @household.guests.each do |guest|
      guest.salutation = params["guest_#{guest.id}_salutation"]
      guest.first = params["guest_#{guest.id}_first"]
      guest.last = params["guest_#{guest.id}_last"]
      guest.email = params["guest_#{guest.id}_email"]
      guest.save
    end
    redirect_to rsvp_form_household_path(@household.id, @household.unique_hex), notice: "The names on your RSVP have been updated"
  end

  def rsvp_form
    render layout: 'home_layout'
  end

  def rsvp_submission
    @household.guests.each do |guest|
      guest.rsvps.each do |rsvp|
        rsvp.status = params["rsvp_#{rsvp.id}_status"]
        rsvp.save
      end
    end

    html = "<p>Your RSVP to Kriti and Arjun's wedding has been updated. Here's what we've got:</p>"
    @household.guests.each do |guest|
      html << "<div><strong>#{guest.full_name}...</strong></div>"
      html << "<ul>"
      guest.rsvps.each do |rsvp|
        html << "<li>#{rsvp.readable_status} the #{rsvp.event.name}</li>"
      end
      html << "</ul>"
    end
    html << "<p><a href='http://www.kritiandarjun.com/households/#{@household.id }/rsvp'>View your RSVP status on the website</a></p>"
    html << "<div>If you have any questions, please email Arjun at <a href='mailto:avenkat2@gmail.com'>avenkat2@gmail.com</a>.</div>"
    html << "<div>Kriti and Arjun</div>"
    text = "Your RSVP for Kriti and Arjun's wedding has been updated.\n View your RSVP at http://kritiandarjun.com/households/#{@household.id}/rsvp"

    client = SendGrid::Client.new(api_key: ENV["sendgrid_api_key"])
    @household.guests.each do |guest|
      if guest.email.present?
        mail = SendGrid::Mail.new do |m|
          m.to = guest.email
          m.from = 'noreply@arjunandkriti.com'
          m.subject = "Updated RSVP for Kriti and Arjun's wedding"
          m.text = text
          m.html = html
        end
        res = client.send(mail)
        puts res.inspect
      end
    end
    redirect_to rsvp_status_household_path(@household.id, @household.unique_hex), notice: "Your RSVP has been updated"
  end

  def rsvp_status
    session[:household_id] = @household.id
    render layout: 'home_layout'
  end

  def printable_rsvp_status
    render layout: 'print'
  end

  def logout
    reset_session
    redirect_to root_url
  end

  # GET /households
  # GET /households.json
  def index
    @households = Household.all
  end

  # GET /households/1
  # GET /households/1.json
  def show
  end

  # GET /households/new
  def new
    @household = Household.new
  end

  # GET /households/1/edit
  def edit
  end

  # POST /households
  # POST /households.json
  def create
    @household = Household.new(household_params)

    respond_to do |format|
      if @household.save
        format.html { redirect_to @household, notice: 'Household was successfully created.' }
        format.json { render :show, status: :created, location: @household }
      else
        format.html { render :new }
        format.json { render json: @household.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /households/1
  # PATCH/PUT /households/1.json
  def update
    respond_to do |format|
      if @household.update(household_params)
        format.html { redirect_to @household, notice: 'Household was successfully updated.' }
        format.json { render :show, status: :ok, location: @household }
      else
        format.html { render :edit }
        format.json { render json: @household.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /households/1
  # DELETE /households/1.json
  def destroy
    @household.destroy
    respond_to do |format|
      format.html { redirect_to households_url, notice: 'Household was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_household
      @household = Household.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def household_params
      params.require(:household).permit(:name)
    end
end
