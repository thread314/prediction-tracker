class FeedbackMailer < ApplicationMailer
  default from: 'e95dad66bb34fc273631@cloudmailin.net'

  def feedback_email(username, message)
    @username = username
    @message = message
    mail(to: 'eddie.drury@gmail.com', subject: "New Feedback Message from #{username}")
  end
end
