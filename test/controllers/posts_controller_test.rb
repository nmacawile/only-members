require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  #test "should get index" do
  #  get posts_index_url
  #  assert_response :success
  #end
  
  def setup
    @post = posts(:one)
    @poster = @post.user
    @not_poster = users(:two)
  end
  
  test "should redirect delete when no user is signed in" do
    assert_no_difference "Post.count" do
      delete post_path(@post)
    end
    assert_redirected_to signin_path
  end
  
  test "should redirect delete when post does not belong to signed in user" do
    sign_in_as @not_poster
    assert_no_difference "Post.count" do
      delete post_path(@post)
    end
    assert_redirected_to root_path
  end
  
  test "should delete when a signed in user is deleting his own post" do
    sign_in_as @poster
    assert_difference "Post.count", -1 do
      delete post_path(@post)
    end
    assert_redirected_to @poster
  end

end
