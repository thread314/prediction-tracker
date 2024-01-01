class OutcomesController < ApplicationController
  before_action :set_outcome, only: %i[ show edit update destroy ]

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
