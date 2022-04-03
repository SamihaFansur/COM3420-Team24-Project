# app/controllers/emails_controller.rb
class EmailsController < ApplicationController 

  def meeting_email
    @emails = params[:emails]
    EmailMailer.with(user_emails: [@emails]).meeting_email.deliver_now
  end
end