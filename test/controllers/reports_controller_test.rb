require "test_helper"

class ReportsControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers 

  setup do
    @report = reports(:one)
    @prediction = predictions(:one)
    @user = users(:one)
    @user.confirm
  end

  test "should get index" do
    get reports_url
    assert_response :success
  end

  test "should get new" do
    sign_in @user
    get new_prediction_report_url(@prediction)
    assert_response :success
  end

  test "should create report" do
    sign_in @user
    assert_difference("Report.count") do
      post prediction_reports_url(@prediction), params: { report: { body: @report.body, reason: @report.reason, status: @report.status, prediction_id: @prediction.id } }
    end
    assert_redirected_to prediction_url(@prediction)
  end

  test "should show report" do
    get report_url(@report)
    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get edit_report_url(@report)
    assert_response :success
  end

  test "should destroy report" do
    sign_in @user
    assert_difference("Report.count", -1) do
      delete report_url(@report)
    end

    assert_redirected_to reports_url
  end
end
