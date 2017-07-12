require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:one)
    @other_user = users(:two)
    @user_params = { params: { user: { name: "Valid Name",
                       email: "validunique122@test.com",
                       password: "111111",
                       password_confirmation: "111111" } } }
  end
  
  test "update with valid info" do
    sign_in_as(@user)
    get edit_user_path(@user)
    patch user_path(@user), @user_params
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, "Valid Name"
  end
  
  test "should be valid with password field is blank" do
    @user_params[:params][:user][:password] = ""
    @user_params[:params][:user][:password_confirmation] = ""
    sign_in_as(@user)
    get edit_user_path(@user)
    patch user_path(@user), @user_params
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, "Valid Name"
  end
  
  test "update with invalid info" do
    @user_params[:params][:user][:name] = ""
    @user_params[:params][:user][:email] = ""
    sign_in_as(@user)
    old_name = @user.name
    old_email = @user.email
    get edit_user_path(@user)
    patch user_path(@user), @user_params
    @user.reload
    assert_equal @user.name, old_name
    assert_equal @user.email, old_email
  end
  
  test "valid password reset" do
    sign_in_as(@user)
    get edit_user_path(@user)
    patch user_path(@user), @user_params
    assert flash.any?
    assert_redirected_to @user
  end
end
