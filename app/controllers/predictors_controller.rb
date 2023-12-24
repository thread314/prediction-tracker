class PredictorsController < ApplicationController

  def index
    if params[:query] 
      @predictors = Predictor.search(params[:query])
    else
      @predictors = Predictor.all
    end
  end

end
