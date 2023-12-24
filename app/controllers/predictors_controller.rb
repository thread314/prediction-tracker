class PredictorsController < ApplicationController
  def index
    @predictors = Predictor.all
  end
end
