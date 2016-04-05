if Rails.env == "development" || Rails.env == "test"
  host = "localhost:3000"
else
  host = "www.kritiandarjun.com"
end
include Rails.application.routes.url_helpers
default_url_options[:host] = host
namespace :mail do
  desc "Sends initial RSVP email to all guests"
  task initial_rsvp: :environment do
    Household.all.each do |household|
      unless household.initial_email_sent
        puts "#{household.full_name} Household"
        household.guests.each do |guest|
          if guest.email.present?
            html = "<p>Dear #{guest.full_name},</p>"
            html << "<p>We would love for you join us at our wedding on June 11<sup>th</sup>! You should be receiving a paper invitation in the mail soon, but you can RSVP at any time and access event information using the following link:</p>"
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
            if res.code == 200
              if household.initial_email_sent == false
                household.initial_email_sent = true
                household.save
              end
              puts "    email sent to #{guest.full_name} at #{guest.email}"
            else
              puts "    there was an error sending to #{guest.full_name} at #{guest.email}"
              puts res.inspect
            end
            sleep 1
          else
            puts "    no email present for #{guest.full_name}"
          end
        end
      end
    end
  end
end
