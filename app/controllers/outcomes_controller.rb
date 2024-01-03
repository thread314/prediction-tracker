class OutcomesController < ApplicationController
  before_action :set_outcome, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :vote]

  # GET /outcomes/1 or /outcomes/1.json
  def show
    @comments = @outcome.comments
  end

  # GET /outcomes/new
  def new
    @prediction = Prediction.find(params[:prediction_id])
    @outcome = @prediction.outcomes.build
  end

  # GET /outcomes/1/edit
  def edit
  end

  # POST /outcomes or /outcomes.json
  def create
    @prediction = Prediction.find(params[:prediction_id])
    @outcome = @prediction.outcomes.build(outcome_params)
    @outcome.update(user_id: current_user.id)
    respond_to do |format|
      if @outcome.save
        format.html { redirect_to prediction_path(@prediction), notice: "Outcome was successfully created." }
        format.json { render :show, status: :created, location: @outcome }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @outcome.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /outcomes/1 or /outcomes/1.json
  def update
    @prediction = @outcome.prediction
    respond_to do |format|
      if @outcome.update(outcome_params)
        format.html { redirect_to prediction_path(@prediction), notice: "Outcome was successfully updated." }
        format.json { render :show, status: :ok, location: @outcome }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @outcome.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /outcomes/1 or /outcomes/1.json
  def destroy
    @outcome.destroy!
    @prediction = @outcome.prediction

    respond_to do |format|
      format.html { redirect_to prediction_path(@prediction), notice: "Outcome was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def vote
    @outcome = Outcome.find(params[:votable_id])
    @votedirection = params[:vote]
    @currentvote = current_user.voted_as_when_voted_for @outcome

    if @currentvote == true && @votedirection == "Upvote"
      @outcome.unliked_by current_user
    elsif @votedirection == "Upvote"
      @outcome.liked_by current_user
    elsif @currentvote == false && @votedirection == "Downvote"
      @outcome.undisliked_by current_user
    elsif @votedirection == "Downvote"
      @outcome.disliked_by current_user
    end

    redirect_back(fallback_location: root_path)

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_outcome
      @outcome = Outcome.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def outcome_params
      params.require(:outcome).permit(:result, :body)
    end
end
