class PredictionsController < ApplicationController
  before_action :set_prediction, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, only: [:new, :create, :vote ]
  before_action :owner_or_admin?, only: [ :edit, :update, :destroy ]

  # GET /predictions or /predictions.json
  def index
    if params[:query] == "due"
      rawpredictions = Prediction.where("duedate < ?", Date.today)
    elsif params[:query] == "due-no-outcome"
      rawpredictions = Prediction.left_outer_joins(:outcomes).where(outcomes: { id: nil }).where("duedate < ?", Date.today)
    elsif params[:query] == "users"
      rawpredictions = current_user.predictions
    else
      rawpredictions = Prediction.all
    end
    rawpredictions = rawpredictions.order(:created_at)
    @predictions = rawpredictions.paginate(page: params[:page], per_page: 10)
  end

  # GET /predictions/1 or /predictions/1.json
  def show
    @predictor = @prediction.predictor
    @outcomes = @prediction.outcomes
    @comments = @prediction.comments.order(:created_at)
  end

  # GET /predictions/new
  def new
    @predictor = Predictor.find(params[:predictor_id])
    @prediction = @predictor.predictions.build()
  end

  # GET /predictions/1/edit
  def edit
  end

  # POST /predictions or /predictions.json
  def create
    @predictor = Predictor.find(params[:predictor_id])
    @prediction = @predictor.predictions.build(prediction_params)
    @prediction.update(user_id: current_user.id)
    @prediction.liked_by current_user
    respond_to do |format|
      if @prediction.save
        format.html { redirect_to prediction_path(@prediction), notice: "Prediction was successfully created." }
        # format.html { redirect_to root_path, notice: "Prediction was successfully created." }
        format.json { render :show, status: :created, location: @prediction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @prediction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /predictions/1 or /predictions/1.json
  def update
    respond_to do |format|
      if @prediction.update(prediction_params)
        format.html { redirect_to prediction_path(@prediction), notice: "Prediction was successfully updated." }
        format.json { render :show, status: :ok, location: @prediction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @prediction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /predictions/1 or /predictions/1.json
  def destroy
    @prediction.destroy!

    respond_to do |format|
      format.html { redirect_to predictions_url, notice: "Prediction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def vote

    @prediction = Prediction.find(params[:votable_id])
    @votedirection = params[:vote]
    @currentvote = current_user.voted_as_when_voted_for @prediction

    if @currentvote == true && @votedirection == "Upvote"
      @prediction.unliked_by current_user
    elsif @votedirection == "Upvote"
      @prediction.liked_by current_user
    elsif @currentvote == false && @votedirection == "Downvote"
      @prediction.undisliked_by current_user
    elsif @votedirection == "Downvote"
      @prediction.disliked_by current_user
    end

    redirect_back(fallback_location: root_path)
    # render partial: 'app/views/layouts/voting.html.erb', locals: { votable: @prediction, destination: prediction_vote_path(@prediction) }

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_prediction
    @prediction = Prediction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def prediction_params
    params.require(:prediction).permit(:title, :body, :query, :duedate, :votable_id, :vote)
  end

  def owner_or_admin?
    authenticate_user!
    unless current_user.admin? || @prediction.user_id == current_user.id then
      flash[:alert] = "You are not authorized to view this page."
      redirect_to root_path 
    end
  end

end
