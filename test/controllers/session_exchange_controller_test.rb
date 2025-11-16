require "test_helper"

class SessionExchangeControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:one)
    @admin.update!(github_id: ENV.fetch("ALLOWED_ADMIN_GITHUB_IDS", "1").split(",").first.to_i)
    @non_admin = users(:two)
  end

  #--------------------------------------
  # MISSION CONTROL ACCESS TESTS
  #--------------------------------------

  test "admin can exchange JWT for session and access Mission Control" do
    jwt = JsonWebToken.encode({ user_id: @admin.id })

    get session_exchange_path(token: jwt, redirect: "/admin/jobs")

    assert_redirected_to "/admin/jobs"
    assert_equal @admin.id, session["warden.user.user.key"][0][0]
  end

  test "non-admin cannot access Mission Control" do
    jwt = JsonWebToken.encode({ user_id: @non_admin.id })

    get session_exchange_path(token: jwt, redirect: "/admin/jobs")

    assert_response :forbidden
    assert_equal "Access denied. Mission Control requires admin role.", response.body
  end

  test "rejects invalid redirect paths" do
    jwt = JsonWebToken.encode({ user_id: @admin.id })

    get session_exchange_path(token: jwt, redirect: "/admin/stats")

    assert_response :bad_request
    assert_includes response.body, "Invalid redirect path"
  end

  #--------------------------------------
  # SECURITY TESTS
  #--------------------------------------

  test "rejects missing token" do
    get session_exchange_path(redirect: "/admin/jobs")

    assert_response :unauthorized
    assert_equal "Authentication required", response.body
  end

  test "rejects invalid JWT" do
    get session_exchange_path(token: "invalid-jwt", redirect: "/admin/jobs")

    assert_response :unauthorized
    assert_equal "Invalid or expired token", response.body
  end

  test "rejects expired JWT" do
    jwt = JsonWebToken.encode({ user_id: @admin.id }, exp: 1.hour.ago)

    get session_exchange_path(token: jwt, redirect: "/admin/jobs")

    assert_response :unauthorized
    assert_equal "Invalid or expired token", response.body
  end

  test "rejects non-whitelisted redirect paths" do
    jwt = JsonWebToken.encode({ user_id: @admin.id })

    get session_exchange_path(token: jwt, redirect: "/evil/path")

    assert_response :bad_request
    assert_includes response.body, "Invalid redirect path"
  end

  test "rejects missing redirect parameter" do
    jwt = JsonWebToken.encode({ user_id: @admin.id })

    get session_exchange_path(token: jwt)

    assert_response :bad_request
    assert_includes response.body, "Invalid redirect path"
  end

  test "rejects non-existent user" do
    jwt = JsonWebToken.encode({ user_id: 99999 })

    get session_exchange_path(token: jwt, redirect: "/admin/jobs")

    assert_response :unauthorized
    assert_equal "User not found", response.body
  end
end
