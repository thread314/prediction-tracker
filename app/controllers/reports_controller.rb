class ReportsController < ApplicationController
  before_action :set_report, only: [ :show, :edit, :update, :destroy ]
  before_action :set_reportable, only: [ :new, :create, :edit, :update ]
  before_action :authenticate_user!
  before_action :is_admin?, except: [ :new, :create ]

  # GET /reports or /reports.json
  def index
    if params[:query] 
      rawreports = Report.where(status: params[:query])
    else
      rawreports = Report.all
    end
    @reports = rawreports.paginate(page: params[:page], per_page: 10)
  end

  # GET /reports/1 or /reports/1.json
  def show
    @comments = @report.comments
  end

  # GET /reports/new
  def new
    @report = @reportable.reports.build
    if @report.reportable_type == "Prediction"
      @reason_list = Report.reasons.keys.map { |reason| [reason.titleize, reason] }
    elsif @report.reportable_type == "Outcome"
      @reason_list = Report.reasons.keys.drop(5).map { |reason| [reason.titleize, reason] }
    end
  end

  # GET /reports/1/edit
  def edit
    if @report.reportable_type == "Prediction"
      @reason_list = Report.reasons.keys.map { |reason| [reason.titleize, reason] }
    elsif @report.reportable_type == "Outcome"
      @reason_list = Report.reasons.keys.drop(5).map { |reason| [reason.titleize, reason] }
    end
  end

  # POST /reports or /reports.json
  def create
    @report = @reportable.reports.build(report_params)
    @report.update(user_id: current_user.id)
    if @report.reportable_type == "Prediction"
      destination = prediction_path(@reportable)
    elsif @report.reportable_type == "Outcome"
      destination = prediction_path(@reportable.prediction)
    end

    if @report.reportable_type == "Prediction"
      @reason_list = Report.reasons.keys.map { |reason| [reason.titleize, reason] }
    elsif @report.reportable_type == "Outcome"
      @reason_list = Report.reasons.keys.drop(5).map { |reason| [reason.titleize, reason] }
    end

    respond_to do |format|
      if @report.save
        format.html { redirect_to destination, notice: "Report was successfully created." }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1 or /reports/1.json
  def update
    if @report.reportable_type == "Prediction"
      destination = prediction_path(@reportable)
    elsif @report.reportable_type == "Outcome"
      destination = prediction_path(@reportable.prediction)
    end

    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to destination, notice: "Report was successfully updated." }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1 or /reports/1.json
  def destroy
    @report.destroy!

    respond_to do |format|
      format.html { redirect_to reports_url, notice: "Report was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_report
    @report = Report.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def report_params
    params.require(:report).permit(:reason, :body, :status)
  end

  def set_reportable
    if @report
      @reportable = @report.reportable
    elsif params[:prediction_id]
      @reportable = Prediction.find(params[:prediction_id]) 
    elsif params[:outcome_id]
      @reportable = Outcome.find(params[:outcome_id]) 
    end
  end

  def is_admin?
    unless current_user.admin? then
      flash[:alert] = "You are not authorized to view this page."
      redirect_to root_path 
    end
  end

end
