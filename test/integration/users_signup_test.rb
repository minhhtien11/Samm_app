require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "valid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: "",
                               email: "user@invalid",
                               password:      "password",
                              password_confirmation: "password" }
    end
    #cassert_template 'users/new'
    assert_template 'users/show'
    assert is_logged_in?
    end
end
