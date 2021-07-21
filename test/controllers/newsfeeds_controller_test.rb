require 'test_helper'

class NewsfeedsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get newsfeeds_index_url
    assert_response :success
  end

end
