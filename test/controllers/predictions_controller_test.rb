require "test_helper"

class PredictionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers 

  setup do
    @prediction = predictions(:one)
    @predictor = Predictor.last
    @user = users(:one)
    @user.confirm
  end

  test "should get index" do
    get predictions_url
    assert_response :success
  end

  test "should get new" do
    sign_in @user
    get new_predictor_prediction_url(@predictor)
    assert_response :success
  end

  test "should create prediction" do
    sign_in @user
    assert_difference("Prediction.count") do
      post predictor_predictions_url(@predictor), params: { prediction: {title: "title", body: "body", duedate: "Mon, 01 Jan 2024"} }
    end
    assert_redirected_to prediction_url(Prediction.last)
  end

  test "should show prediction" do
    get prediction_url(@prediction)
    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get edit_prediction_url(@prediction)
    assert_response :success
  end

  test "should update prediction" do
    sign_in @user
    patch prediction_url(@prediction), params: { prediction: {title: "title", body: "body", duedate: "Mon, 01 Jan 2024" } }
    assert_redirected_to prediction_url(@prediction)
  end

  test "should destroy prediction" do
    sign_in @user
    assert_difference("Prediction.count", -1) do
      delete prediction_url(@prediction)
    end

    assert_redirected_to predictions_url
  end
end
