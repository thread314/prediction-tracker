class ReportsController < ApplicationController
  before_action :set_report, only: %i[ show edit update destroy ]
  before_action :set_reportable, only: %i[ update new create ]

  # GET /reports or /reports.json
  def index
    @reports = Report.all
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
    if @report.reportable_type == "Prediction"
      destination = prediction_path(@reportable)
    elsif @report.reportable_type == "Outcome"
      destination = prediction_path(@reportable.prediction)
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
    if params[:prediction_id]
      @reportable = Prediction.find(params[:prediction_id]) 
    elsif params[:outcome_id]
      @reportable = Outcome.find(params[:outcome_id]) 
    end
  end

end
