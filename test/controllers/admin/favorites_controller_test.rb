require "test_helper"

class Admin::FavoritesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_favorites_index_url
    assert_response :success
  end
end
