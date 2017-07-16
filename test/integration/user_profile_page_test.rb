require 'test_helper'

class UserProfilePageTest < ActionDispatch::IntegrationTest
  test "posts should be paginated" do
    sign_in_as users(:one)
    user = users(:four)
    get user_path(user)
    assert_template "users/show"
    assert_select "div.pagination"
    user.posts.paginate(page: 1, per_page: 5).each do |post|
      assert_select "a[href=?]", user_path(post.user), text: post.user.name
      assert_select "p", post.content
    end
  end
  
  test "posts should be hidden when viewer is not signed in" do
    user = users(:four)
    get user_path(user)
    assert_template "users/show"
    user.posts.paginate(page: 1, per_page: 5).each do |post|
      assert_select "a[href=?]", user_path(post.user), text: post.user.name, count: 0
      assert_select "p", post.content, count: 0
    end
  end
  
  test "posts should show delete links if a signed in user is viewing his profile" do
    user = users(:four)
    sign_in_as(user)
    get user_path(user)
    assert_template "users/show"
    assert_select "div.pagination"
    user.posts.paginate(page: 1, per_page: 5).each do |post|
      assert_select "a[href=?]", post_path(post), text: "delete"
    end
  end
  
  test "posts should not show delete links if the viewer of the profile is not the owner" do
    user = users(:four)
    get user_path(user)
    user.posts.paginate(page: 1, per_page: 5).each do |post|
      assert_select "a[href=?]", post_path(post), text: "delete", count: 0
    end
  end
end
