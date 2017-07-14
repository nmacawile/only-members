require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @poster = users(:one)
    @post = Post.new(content: "TEXT TEXT TEXT", user: @poster)
  end
  
  test "should be valid" do
    assert @post.valid?
  end
  
  test "content should not be empty" do
    @post.content = "    "
    assert_not @post.valid?
  end
  
  test "content should not be too long" do
    @post.content = "a" * 500
    assert @post.valid?
    @post.content = "a" * 501
    assert_not @post.valid?
  end
  
  test "should be tied to a user" do
    @post.user = nil
    assert_not @post.valid?
  end
  
  test "should be deleted when the user is deleted" do
    @post.save
    @poster.destroy
    assert_not Post.exists?(@post.id)
  end
  
  test "should return newest records first" do
    all_posts = Post.all
    assert_equal all_posts.first, posts(:three)
    assert_equal all_posts.second, posts(:six)
    assert_equal all_posts.third, posts(:five)
  end
  
  test "should return all posts by a user" do
    user_posts = Post.user_posts(@poster.id)
    assert_equal user_posts.count, 3
    [posts(:one), posts(:two), posts(:three)].each do |post|
      assert_includes(user_posts, post)
    end
  end
end
