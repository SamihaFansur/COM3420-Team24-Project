# app/mailers/email_mailer.rb
class EmailMailer < ApplicationMailer
  default from: 'ebell3@sheffield.ac.uk'

  def meeting_email
    @meeting = params[:meeting]
    @meeting_attendees = @meeting.attendees
    mail(to:  @meeting_attendees, subject: 'Next scrutiny panel meeting')
  end

  def ecf_submitted
    @ecf = params[:ecf]
    mail(to: @ecf.user.mail, subject: 'Successfully submitted an ecf')
  end

  def ecf_updated
    @ecf = params[:ecf]
    mail(to: @ecf.user.mail, subject: 'Successfully updated an ecf')
  end
  
  def ecf_status_complete
    @ecf = params[:ecf]
    mail(to: @ecf.user.mail, subject: 'ECF decision made')
  end

  def ecf_added_to_agenda
    @agenda = params[:agenda]
    mail(to: @agenda.ecf.user.mail, subject: 'ECF added to next scrutiny panel meeting')
  end

  def ecf_removed_from_agenda
    @agenda = params[:agenda]
    mail(to: @agenda.ecf.user.mail, subject: 'ECF removed from next scrutiny panel meeting')
  end

  def ecf_added_to_updated_agenda
    @agenda = params[:agenda]
    mail(to: @agenda.ecf.user.mail, subject: 'Next scrutiny panel meeting time updated')
  end
end
