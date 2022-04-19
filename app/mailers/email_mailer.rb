# app/mailers/email_mailer.rb
class EmailMailer < ApplicationMailer
    default from: 'scrutinypanelmeetings@gmail.com'

  def meeting_email
    @emails = params[:input_emails]
    mail(to: -> { @emails }, subject: 'Test :)')
  end

  def ecf_submitted
    @ecf = params[:ecf]
    mail(to: @ecf.user.mail, subject: "Successfully submitted an ecf")
  end

  def ecf_updated
    @ecf = params[:ecf]
    mail(to: @ecf.user.mail, subject: "Successfully updated an ecf")
  end
  
  def ecf_added_to_agenda
    @agenda = params[:agenda]
    mail(to: @agenda.ecf.user.mail, subject: "ECF added to next scrutiny panel meeting")
  end

  def ecf_removed_from_agenda
    @agenda = params[:agenda]
    mail(to: @agenda.ecf.user.mail, subject: "ECF removed from next scrutiny panel meeting")
  end
  
  def ecf_added_to_updated_agenda
    @agenda = params[:agenda]
    mail(to: @agenda.ecf.user.mail, subject: "Next scrutiny panel meeting time updated")
  end


end