require 'test_helper'

class PostDeletionTest < ActionDispatch::IntegrationTest
  
  def setup
    @post = posts(:one)
    @poster = @post.user
    @admin = users(:admin)
  end
  
  test "should delete when a signed in user is deleting his own post" do
    sign_in_as @poster
    assert_difference "Post.count", -1 do
      delete post_path(@post)
    end
    assert_redirected_to @poster
  end
  
  test "should delete when an admin is deleting any post" do
    sign_in_as @admin
    assert_difference "Post.count", -1 do
      delete post_path(@post)
    end
    assert_redirected_to @poster
  end
  
end
