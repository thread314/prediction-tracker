require "application_system_test_case"

class OutcomesTest < ApplicationSystemTestCase
  setup do
    @outcome = outcomes(:one)
  end

  test "visiting the index" do
    visit outcomes_url
    assert_selector "h1", text: "Outcomes"
  end

  test "should create outcome" do
    visit outcomes_url
    click_on "New outcome"

    fill_in "Body", with: @outcome.body
    fill_in "Prediction", with: @outcome.prediction_id
    fill_in "Result", with: @outcome.result
    click_on "Create Outcome"

    assert_text "Outcome was successfully created"
    click_on "Back"
  end

  test "should update Outcome" do
    visit outcome_url(@outcome)
    click_on "Edit this outcome", match: :first

    fill_in "Body", with: @outcome.body
    fill_in "Prediction", with: @outcome.prediction_id
    fill_in "Result", with: @outcome.result
    click_on "Update Outcome"

    assert_text "Outcome was successfully updated"
    click_on "Back"
  end

  test "should destroy Outcome" do
    visit outcome_url(@outcome)
    click_on "Destroy this outcome", match: :first

    assert_text "Outcome was successfully destroyed"
  end
end
