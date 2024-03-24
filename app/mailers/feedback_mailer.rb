class FeedbackMailer < ApplicationMailer
  default from: "support@prediction.eddiedrurypbs.com.au"

  def feedback_email(username, message)
    @username = username
    @message = message
    if Rails.env.production?
      @email = URI.parse(ENV['FEEDBACK_EMAIL']) 
    else 
      @email = "support@nostradamn.org"
    end
    mail(to: @email, subject: "Feedback from #{username}")
  end

end
