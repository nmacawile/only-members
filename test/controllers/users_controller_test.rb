require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @other_user = users(:two)
  end
  
  test "should get signup path" do
    get signup_path
    assert_response :success
  end
  
  test "should get edit when user is signed in" do
    sign_in_as(@user)
    get edit_user_path(@user)
    assert_response :success
  end
  
  test "should redirect edit when wrong user is signed in" do
    sign_in_as(@other_user)
    get edit_user_path(@user)
    assert_redirected_to root_path
  end
  
  test "should redirect edit when user is not signed in" do
    get edit_user_path(@user)
    assert_redirected_to signin_path
  end
  
  test "should redirect update when user is not signed in" do
    patch user_path(@user), params: { user: { name: "validname",
                                                  email: "validunique123@example.com",
                                                  password: "222222",
                                                  password_confirmation: "222222" } }
    assert_redirected_to signin_path
  end
  
  test "should redirect update when wrong user is signed in" do
    sign_in_as(@other_user)
    patch user_path(@user), params: { user: { name: "validname",
                                                  email: "validunique123@example.com",
                                                  password: "222222",
                                                  password_confirmation: "222222" } }
    assert_redirected_to root_path
  end

  test "should get index" do
    get users_path
    assert_response :success
  end

end
