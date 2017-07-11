require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get signup path" do
    get signup_path
    assert_response :success
  end

  test "should get index" do
    get users_path
    assert_response :success
  end

end
