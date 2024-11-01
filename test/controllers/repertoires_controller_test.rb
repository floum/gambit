require "test_helper"

class RepertoiresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get repertoires_index_url
    assert_response :success
  end
end
