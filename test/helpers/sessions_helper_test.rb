require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  def setup
    @user = users(:one)
    remember(@user)
  end
  
  test "current_user returns right user when session is nil" do
    assert_equal current_user, @user
    assert user_signed_in?
  end
  
  test "current_user returns nil when digest is wrong" do
    @user.remember #generates new token and digest
    assert_nil current_user
  end
end
