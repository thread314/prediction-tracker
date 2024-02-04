class FeedbackMailer < ApplicationMailer
  default from: "no-reply@salty-sea-96190-e9acf7b934b2.herokuapp.com"

  def feedback_email(username, message)
    @username = username
    @message = message
    mail(to: 'eddie.drury@gmail.com', subject: "New Feedback Message from #{username}")
  end
end
