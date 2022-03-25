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
    assert_template 'users/new'
    end
end
