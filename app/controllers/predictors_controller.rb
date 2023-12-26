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

  def create

    wikiurl = params[:wikiurl]
    wikientry = Wikipedia.find(wikiurl)

    if wikientry.content
      @predictor = Predictor.new wikiurl: wikiurl, 
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
