require "test_helper"

class PredictorsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers 

  setup do
    @user = users(:one)
    @user.confirm
  end

  # test "should return bad wikipedia url" do
  #   sign_in @user
  #   post predictors, params: {"predictor"=>{"wikiurl"=>"jfjf"}, "commit"=>"Create Predictor"}
  #   assert_equal 'Predictor Not Found: Incorrect URL', flash[:notice]
  # end

end
