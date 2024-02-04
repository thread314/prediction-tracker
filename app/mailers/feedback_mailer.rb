class FeedbackMailer < ApplicationMailer
  default from: "eddie@eddiedrurypbs.com.au"

  def feedback_email(username, message)
    @username = username
    @message = message
    mail(to: 'eddie.drury@gmail.com', subject: "New Feedback Message from #{username}")
  end
end
