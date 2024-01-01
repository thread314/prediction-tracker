class PredictionsController < ApplicationController
  before_action :set_prediction, only: %i[ show edit update destroy ]

  # GET /predictions or /predictions.json
  def index
    if params[:predictor_id]
      @predictor = Predictor.find(params[:predictor_id])
      @predictions = @predictor.predictions
    else
      @predictions = Prediction.all
    end
  end

  # GET /predictions/1 or /predictions/1.json
  def show
    @predictor = @prediction.predictor
    @outcomes = @prediction.outcomes
    @comments = @prediction.comments
  end

  # GET /predictions/new
  def new
    @predictor = Predictor.find(params[:predictor_id])
    @prediction = @predictor.predictions.build
  end

  # GET /predictions/1/edit
  def edit
  end

  # POST /predictions or /predictions.json
  def create
    @predictor = Predictor.find(params[:predictor_id])
    @prediction = @predictor.predictions.build(prediction_params)
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prediction
      @prediction = Prediction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def prediction_params
      params.require(:prediction).permit(:title, :body, :duedate)
    end

end
