# app/mailers/email_mailer.rb
class EmailMailer < ApplicationMailer
  default from: 'ebell3@sheffield.ac.uk'

  def meeting_email
    @meeting = params[:meeting]
    # @meeting_attendees = @meeting.attendees.split(', ')
    @meeting_attendees = @meeting.attendees
    mail(to:  @meeting_attendees, subject: 'Next scrutiny panel meeting')

    # print("\n%%%%%%%%%%%%%%%%%%%%%%%%%%\n")
    # print(@@meeting_attendees.collect.join(","))
    # print("\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n")
    # @meeting_attendees.each do |attendee|
    #   print("\n----------------attendees being emailed------------\n")
    #   print(attendee)
    #   mail(to: attendee, subject: 'Next scrutiny panel meeting')
    #   print("\n-------------------\n")
    # end
  end

  def ecf_submitted
    @ecf = params[:ecf]
    mail(to: @ecf.user.mail, subject: 'Successfully submitted an ecf')
  end

  def ecf_updated
    @ecf = params[:ecf]
    mail(to: @ecf.user.mail, subject: 'Successfully updated an ecf')
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
