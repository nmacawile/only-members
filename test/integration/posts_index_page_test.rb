require 'test_helper'

class PostsIndexPageTest < ActionDispatch::IntegrationTest
  test "should be paginated" do
    sign_in_as users(:one)
    get root_path
    assert_template 'posts/index'
    assert_select "div.pagination"
    Post.paginate(page: 1, per_page: 10).each do |post|
      assert_select "a[href=?]", user_path(post.user), text: post.user.name
      assert_select "p", post.content
    end
  end
  
  test "posts should show delete links if owned by the signed in user" do
    user = users(:one)
    sign_in_as(user)
    get root_path
    user.posts.paginate(page: 1, per_page: 5).each do |post|
      if post.user == user
        assert_select "a[href=?]", post_path(post), text: "delete"
      else
        assert_select "a[href=?]", post_path(post), text: "delete", count: 0
      end
    end
  end
  
  test "post should  be sanitized" do
    sign_in_as users(:one)
    post posts_path, params: { post: { content: "<script>do_nasty_stuff()</script>" } }
    get root_path
    assert_select "p", text: "do_nasty_stuff()"
  end
end
