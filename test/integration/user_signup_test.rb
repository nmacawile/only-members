require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.new(name: "TestUser", email: "testuser@email.com", password: "password", password_confirmation: "password")
  end
  
  test "signup with valid information" do
    assert_difference "User.count", 1 do
      post signup_path, params: { user: { name: @user.name,
                                          email: @user.email,
                                          password: @user.password,
                                          password_confirmation: @user.password_confirmation } }
    end
    assert user_signed_in?
    follow_redirect!
    assert_not flash.empty?
    assert_template "users/show"
  end
  
  test "signup with invalid information" do
    assert_no_difference "User.count" do
      post signup_path, params: { user: { name: @user.name,
                                          email: @user.email,
                                          password: @user.password,
                                          password_confirmation: "aaaa" } }
    end
    assert_not user_signed_in?
  end
end
