class HouseholdsController < ApplicationController
  before_action :check_if_admin, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :set_household, only: [:show, :edit, :update, :destroy, :rsvp_submission, :rsvp_status, :printable_rsvp_status, :check_names, :update_names, :rsvp_form]
  before_action :check_for_editable_rsvp, only: [:check_names, :rsvp_form]

  def check_if_admin
    unless current_user && current_user.admin?
      redirect_to root_url, alert: "You're not authorized to go there"
    end
  end

  def check_for_editable_rsvp
    unless @household.can_edit_rsvp?
      redirect_to rsvp_status_household_path(@household.id, @household.unique_hex), alert: "Your RSVP has been finalized. If you still need to make changes, please email Arjun at avenkat2@gmail.com"
    end
  end

  def resend_rsvp
    guest = Guest.find_by_email(params[:email])
    household = guest.household
    if guest
      html = "<p>Dear #{guest.full_name},</p>"
      html << "<p>We would love for you to join us at our wedding on June 11<sup>th</sup>! You should be receiving a paper invitation in the mail soon, but you can RSVP at any time and access event information using the following link:</p>"
      html << "<p><a href='#{check_names_household_url(household, household.unique_hex)}'>#{check_names_household_url(household, household.unique_hex)}</a></p>"
      html << "<p>We look forward to hearing back from you! Please reply by May 1<sup>st</sup>.</p>"
      html << "<p>- Kriti and Arjun</p>"
      text = "We would love to have you join us at our wedding. Please access the following URL to RSVP: #{check_names_household_url(household, household.unique_hex)} - Kriti and Arjun"
      client = SendGrid::Client.new(api_key: ENV["sendgrid_api_key"])
      mail = SendGrid::Mail.new do |m|
        m.to = guest.email
        m.from = 'noreply@kritiandarjun.com'
        m.subject = "RSVP for Kriti and Arjun's wedding"
        m.text = text
        m.html = html
      end
      res = client.send(mail)
      puts res.inspect
      if res.code == 200 && household.initial_email_sent == false
        household.initial_email_sent = true
        household.save
      end
      redirect_to root_url, notice: "The RSVP email was resent to #{params[:email]}"
    else
      redirect_to root_url, alert: "We couldn't find your email address. Please make sure you entered it correctly or try the email of another member of your household. Contact Arjun at avenkat2@gmail.com for assistance"
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

    if @household.replied_at.blank?
      @household.replied_at = Time.now
      @household.save
    end

    html = "<p>Your RSVP to Kriti and Arjun's wedding has been updated. Here's what we've got:</p>"
    Event.all.each do |event|
      if event.rsvps_for_household(@household).present?
        html << "<div><strong>#{event.name}</strong></div>"
        html << "<ul>"
        event.rsvps_for_household(@household).each do |rsvp|
          html << "<li>#{rsvp.guest.full_name} #{rsvp.readable_status}</li>"
        end
        html << "</ul>"
      end
    end


    html << "<p><a href='#{rsvp_status_household_url(@household, @household.unique_hex)}'>View your RSVP status on the website</a></p>"
    html << "<div>If you have any questions, please email Arjun at <a href='mailto:avenkat2@gmail.com'>avenkat2@gmail.com</a>.</div>"
    html << "<p>- Kriti and Arjun</p>"
    text = "Your RSVP for Kriti and Arjun's wedding has been updated.\n View your RSVP at #{rsvp_status_household_url(@household, @household.unique_hex)}"

    client = SendGrid::Client.new(api_key: ENV["sendgrid_api_key"])
    @household.guests.each do |guest|
      if guest.email.present?
        mail = SendGrid::Mail.new do |m|
          m.to = guest.email
          m.from = 'noreply@kritiandarjun.com'
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
    if params[:filter]
      @filtered_households = Household.by_category(params[:filter])
      @household_filter_class = params[:filter].parameterize
    else
      @filtered_households = Household.all
      @household_filter_class = "all"
    end
    @households = @filtered_households.order(:last).page params[:page]
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
      params.require(:household).permit(:name, :first, :last)
    end
end
