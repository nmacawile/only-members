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
    assert_redirected_to root_path
  end
  
  test "should reject invalid signin details" do
    post signin_path, params: { session: { email: @user.email, password: "" } }
    assert_not user_signed_in?
  end
end
