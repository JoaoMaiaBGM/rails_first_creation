require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    post users_path, params: { user: { email_address: "test@example.com", password: "password", password_confirmation: "password" } }
    assert_response :redirect
  end
end
