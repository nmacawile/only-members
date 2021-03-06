require 'test_helper'

class UserSigninTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.new(name: "Test User", email: "test@email.com", password: "password")
    @user.save
  end
  
  test "user signin followed by a signout" do
    post signin_path, params: { session: { email: @user.email, password: @user.password } }
    assert user_signed_in?
    assert_redirected_to @user
    delete signout_path
    assert_not user_signed_in?
    assert_not flash.empty?
    assert_redirected_to root_path
  end
  
  test "should reject invalid signin details" do
    post signin_path, params: { session: { email: @user.email, password: "" } }
    assert_not user_signed_in?
    assert_not flash.empty?
  end
  
  test "signin with remembering" do
    sign_in_as(@user, remember_me: '1')
    assert_equal cookies['remember_token'], assigns(:user).remember_token
  end

  test "signin without remembering" do
    sign_in_as(@user, remember_me: '1')
    sign_in_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end
end
