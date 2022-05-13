# frozen_string_literal: true

# Controller for email functionality
class EmailsController < ApplicationController
  # Generates an email for a meeting, addressed to the attendees

  # i dont think this controller is being used
  def meeting_email
    @emails = params[:emails]
    EmailMailer.with(user_emails: [@emails]).meeting_email.deliver_now
    Rails.logger.debug('***************************************************')
    flash[:notice] = 'Attendees notified'
    redirect_to meetings_path
  end
end
