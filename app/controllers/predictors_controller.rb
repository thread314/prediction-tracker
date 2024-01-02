class PredictorsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    if params[:query] 
      @predictors = Predictor.search(params[:query])
    else
      @predictors = Predictor.all
    end
  end

  def show
    @predictor = Predictor.find(params[:id])
    @predictions = Prediction.where(predictor_id: params[:id])
  end

  def new
    if params[:query]
      wikientry = Wikipedia.find(params[:query])
      wikiurl = wikientry.fullurl
    end
    if Predictor.find_by(wikiurl: wikiurl) 
      @predictor = Predictor.find_by(wikiurl: wikiurl)
    elsif wikientry 
      @predictor = Predictor.new wikiurl: wikiurl, 
                                 title: wikientry.title,
                                 image: wikientry.main_image_url,
                                 summary: wikientry.summary
    end
  end
  
  def create
    wikientry = Wikipedia.find(params[:predictor]['wikiurl'])
    if wikientry.content
      @predictor = Predictor.new wikiurl: wikientry.fullurl, 
                                 title: wikientry.title,
                                 image: wikientry.main_image_url,
                                 summary: wikientry.summary
      @predictor.save
      redirect_to predictor_url(@predictor), notice: "Predictor Created Successfully"
    else
      redirect_to new_predictor_path, notice: "Predictor Not Found: Incorrect URL"
    end

  end

end
