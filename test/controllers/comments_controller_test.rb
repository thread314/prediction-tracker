require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers 

  setup do
    @comment = comments(:one)
    @prediction = predictions(:one)
    @user = users(:one)
    @user.confirm
  end

  test "should get new" do
    sign_in @user
    get new_prediction_comment_url(@prediction)
    assert_response :success
  end

  test "should create comment" do
    sign_in @user
    assert_difference("Comment.count") do
      post prediction_comments_url(@prediction), params: { comment: { body: @comment.body } }
    end
    assert_redirected_to prediction_url(@prediction)
  end

  test "should destroy comment" do
    # assert_difference("Comment.count", -1) do
    #   delete comment_path(@comment)
    # end
    # assert_redirected_to prediction_url(@prediction)
  end

end
