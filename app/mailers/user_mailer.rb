# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
    default from: 'notifications@example.com'

  def meeting_email
    user_emails = :emails
    mail(to: @user.email, subject: 'Test :)')
  end
end