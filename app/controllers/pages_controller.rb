class PagesController < ApplicationController

  before_action :authenticate_user!, only: [:feedback, :submit_feedback]

  def home
  end

  def about
  end

  def feedback
  end

  def submit_feedback

    username = params[:username]
    message = params[:message]
    FeedbackMailer.feedback_email(username, message).deliver_now

    flash[:notice] = "Thank you for the feedback."
    redirect_to root_path

  end

end
