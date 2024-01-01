class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ destroy ]
  before_action :set_commentable, only: %i[ new create ]

  # GET /comments/new
  def new
    @comment = @commentable.comments.build
  end

  # POST /comments or /comments.json
  def create

    @comment = @commentable.comments.build(comment_params)

    if params[:prediction_id]
      @prediction = Prediction.find(params[:prediction_id])
    elsif params[:outcome_id]
      @outcome = Outcome.find(params[:outcome_id])
    elsif params[:report_id]
      @report = Report.find(params[:report_id])
    end

    respond_to do |format|
      if @comment.save && params[:prediction_id]
        format.html { redirect_to prediction_url(@prediction), notice: "Comment was successfully created." }
      elsif @comment.save && params[:outcome_id]
        format.html { redirect_to outcome_url(@outcome), notice: "Comment was successfully created." }
      elsif @comment.save && params[:report_id]
          format.html { redirect_to report_url(@report), notice: "Comment was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity, notice: "Error saving" }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id)
  end

  def set_commentable
    @commentable = Prediction.find(params[:prediction_id]) if params[:prediction_id]
    @commentable = Outcome.find(params[:outcome_id]) if params[:outcome_id]
    @commentable = Report.find(params[:report_id]) if params[:report_id]
  end

end
