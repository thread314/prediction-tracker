class FeedbackMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def feedback_email(username, message)
    @username = username
    @message = message
    mail(to: 'eddie.drury@gmail.com', subject: "New Feedback Message from #{username}")
  end
end
