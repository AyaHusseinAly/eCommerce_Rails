require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user1 = User.new(email: "user_uni@mysite.com", name: "myuser", password: "Password123", password_confirmation: "Password123", role: "buyer")
    @user2 = User.new(name: "usertwo", password: "Password123", password_confirmation: "Password123", role: "buyer")
    @user3 = User.new(email: "user_unique3@mysite.com", name: "userth", password: "pass", password_confirmation: "pass", role: "buyer")
    @user4 = User.new(email: "user_unique4@mysite.com", password: "Password123", password_confirmation: "Password123", role: "buyer")
    @user5 = User.new(email: "user_unique5@mysite.com", name: "user1", password: "Password123", password_confirmation: "Password123", role: "buyer")
  end

  test "should be valid" do
    assert @user1.valid?
  end
  test "should have email" do
    assert_not @user2.valid?
    assert_not @user2.save
  end
  test "should have min pass 6 letters" do
    assert_not @user3.valid?
    assert_not @user3.save
  end
  test "should have name" do
    assert_not @user4.valid?
    assert_not @user4.save
  end
  test " name only allows letters" do
    assert_not @user5.valid?
    assert_not @user5.save
  end

end
