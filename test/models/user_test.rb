require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  # SETUP TEST
  
  def setup
    @user = User.new(name: "Test User",
                     email: "test@email.com",
                     password: "password",
                     password_confirmation: "password")
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should not be blank" do
    @user.name = "  "
    assert_not @user.valid?
  end
  
  test "name should not be too long" do
    @user.name = "A" * 50
    assert @user.valid?
    @user.name = "A" * 51
    assert_not @user.valid?
  end
  
  test "email should not be blank" do
    @user.email = "  "
    assert_not @user.valid?
  end
  
  # EMAIL TEST
  
  test "email should not be too long" do
    @user.email = ("a" * 244) + "@email.com"
    assert @user.valid?
    @user.email = ("a" * 245) + "@email.com"
    assert_not @user.valid?
  end
  
  test "user validation should reject invalid email format" do
    invalid_emails = %w[ foo
                         foo@
                         foo@bar
                         foo@bar..baz
                         @bar.baz
                         bar.baz
                         foo..bar@bar.baz
                         $foo@bar.baz ]
    invalid_emails.each do |email|
      @user.email = email
      assert_not @user.valid?
    end
  end
  
  test "user validation should accept valid email format" do
    valid_emails = %w[ foo@bar.baz 
                       foo.bar@bar.baz
                       foo-bar@bar.baz
                       foo_bar@bar.baz
                       foo+bar@bar.baz
                       foo@bar.ba.az
                       foo@bar-bar.baz
                       ____@bar.baz
                       foo123@bar.baz
                       123@bar.baz ]
                       
    valid_emails.each do |email|
      @user.email = email
      assert @user.valid?
    end
  end
  
  test "email must be unique" do
    copy = @user.dup
    copy.email.upcase!
    @user.save
    assert_not copy.valid?    
  end
  
  test "email must be saved in lowercase" do
    email_lowercase = @user.email.downcase
    @user.email.upcase!
    @user.save
    assert_equal @user.reload.email, email_lowercase
  end
  
  # PASSWORD TEST
  
  test "password must not be blank" do
    @user.password = " " * 20
    assert_not @user.valid?
  end
  
  test "password must not be too short" do
    @user.password = @user.password_confirmation = "aaaaaa"
    assert @user.valid?
    @user.password = @user.password_confirmation = "aaaaa"
    assert_not @user.valid?
  end
  
  
end
