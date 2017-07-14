require 'test_helper'

class UserDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:admin)
    @user = users(:one)
    @user_posts = @user.posts
  end
  
  test "should delete user and all his posts" do
    sign_in_as @admin
    assert_difference "User.count", -1 do
      delete user_path(@user)
    end
    @user_posts.each do |post|
      assert_not post.exists?
    end
    assert_redirected_to users_path
  end
end
