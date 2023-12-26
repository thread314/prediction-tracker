class PredictorsController < ApplicationController

  def index
    if params[:query] 
      @predictors = Predictor.search(params[:query])
    else
      @predictors = Predictor.all
    end
  end

  def show
    @predictor = Predictor.find(params[:id])
  end

  def new
  end
  
  def confirm
    wikientry = Wikipedia.find(params[:query])
    wikiurl = wikientry.fullurl
    if wikientry.content
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
      redirect_to root_path, notice: "Predictor Created Successfully"
    else
      redirect_to root_path, notice: "Predictor Not Found: Incorrect URL"
    end

  end

end
