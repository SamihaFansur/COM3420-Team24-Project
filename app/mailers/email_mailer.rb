# app/mailers/email_mailer.rb
class EmailMailer < ApplicationMailer
    default from: 'scrutinypanelmeetings@gmail.com'

  def meeting_email
    @emails = params[:input_emails]
    mail(to: -> { @emails }, subject: 'Test :)')
  end
end