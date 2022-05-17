# Controller for email functionality
class EmailsController < ApplicationController
  # Generates an email for a meeting, addressed to the attendees

  # I don't think this controller is being used
  def meeting_email
    @emails = params[:emails]
    EmailMailer.with(user_emails: [@emails]).meeting_email.deliver_now
    # print('***************************************************')
    flash[:notice] = 'Attendees notified'
    redirect_to meetings_path
  end
end
