require 'test_helper'

class UsersIndexPageTest < ActionDispatch::IntegrationTest
  test "should be paginated" do
    get users_path
    assert_template 'users/index'
    assert_select "div.pagination"
    User.paginate(page: 1, per_page: 20).each do |user|
      assert_select "a[href=?]", user_path(user), text: user.name
    end
  end
end
