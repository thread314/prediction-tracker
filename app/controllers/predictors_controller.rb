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
                                 summary: wikientry.summary,
                                 user_id: current_user.id
    end
  end
  
  def create
    wikiurl = params[:predictor]['wikiurl']
    wikientry = Wikipedia.find(wikiurl)
    if not wikientry.content then
      redirect_to new_predictor_path, notice: "Predictor Not Found: Incorrect URL"
    elsif not iswikiurlhuman?(wikiurl) then
      redirect_to new_predictor_path, notice: "Wikipedia entry was not a human"
    else
      @predictor = Predictor.new wikiurl: wikientry.fullurl, 
                                 title: wikientry.title,
                                 image: wikientry.main_image_url,
                                 summary: wikientry.summary,
                                 user_id: current_user.id
      @predictor.save
      redirect_to predictor_url(@predictor), notice: "Predictor Created Successfully"
    end
  end

  private

  def fetch_wikipedia_qcode(page_title)
    encoded_title = URI.encode_www_form_component(page_title)
    url = "https://en.wikipedia.org/api/rest_v1/page/summary/#{encoded_title}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    if response.is_a?(Net::HTTPSuccess)
      data = JSON.parse(response.body)
      if data['wikibase_item']
        return data['wikibase_item']
      else
        return "No wikibase_item available for this page."
      end
    else
      return "Failed to fetch data from Wikipedia."
    end
  end

  def is_human?(q_identifier)
    uri = URI.parse("https://www.wikidata.org/w/api.php?action=wbgetentities&ids=#{q_identifier}&format=json")
    response = Net::HTTP.get_response(uri)
    if response.is_a?(Net::HTTPSuccess)
      data = JSON.parse(response.body)
      
      if data['entities'] && data['entities'][q_identifier] && data['entities'][q_identifier]['claims']
        claims = data['entities'][q_identifier]['claims']
        if claims['P31']
          claims['P31'].any? { |claim| claim.dig('mainsnak', 'datavalue', 'value', 'id') == 'Q5' }
        else
          false
        end
      else
        false
      end
    else
      false
    end
  end

  def iswikiurlhuman? (url)
    delimiter = "wiki/"
    index = url.index(delimiter)
    titleonly = index.nil? ? '' : url[index + delimiter.length..-1]
    qcode = fetch_wikipedia_qcode(titleonly)
    return is_human?(qcode)
  end
  
end
