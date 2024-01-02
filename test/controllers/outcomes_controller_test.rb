require "test_helper"

class OutcomesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @outcome = outcomes(:one)
    @prediction = predictions(:one)
  end

  test "should get new" do
    get new_prediction_outcome_url(@prediction)
    assert_response :success
  end

  test "should create outcome" do
    assert_difference("Outcome.count") do
      post prediction_outcomes_url(@prediction), params: { outcome: { body: @outcome.body, prediction_id: @outcome.prediction_id, result: @outcome.result } }
    end
    assert_redirected_to prediction_url(@prediction)
  end

  test "should show outcome" do
    get outcome_url(@outcome)
    assert_response :success
  end

  test "should get edit" do
    get edit_outcome_url(@outcome)
    assert_response :success
  end

  test "should update outcome" do
    patch outcome_url(@outcome), params: { outcome: { body: @outcome.body, prediction_id: @outcome.prediction_id, result: @outcome.result } }
    assert_redirected_to prediction_path(@prediction)
  end

  test "should destroy outcome" do
    assert_difference("Outcome.count", -1) do
      delete outcome_url(@outcome)
    end
  end

end
