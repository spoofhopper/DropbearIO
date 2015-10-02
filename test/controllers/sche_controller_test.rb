require 'test_helper'

class ScheControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
