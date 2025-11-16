# SessionExchangeController
# Exchanges JWT token for Rails session and redirects to Mission Control
#
# This allows Next.js users to seamlessly access Mission Control (/admin/jobs)
# without requiring separate login via GitHub OAuth.
#
# Usage from Next.js:
#   window.location.href = `${railsUrl}/session_exchange?token=${jwt}&redirect=/admin/jobs`
#
# Security:
#   - Validates JWT token
#   - Requires admin role for Mission Control access
#   - Whitelists allowed redirect paths to prevent open redirects
#
class SessionExchangeController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :create ]

  # Whitelisted redirect paths for security (Mission Control only)
  ALLOWED_REDIRECTS = [ "/admin/jobs" ].freeze

  # GET /session_exchange?token=JWT&redirect=/admin/jobs
  def create
    token = params[:token]
    redirect_path = params[:redirect]

    # Validate token presence
    unless token.present?
      render plain: "Authentication required", status: :unauthorized
      return
    end

    # Validate redirect path is whitelisted
    unless ALLOWED_REDIRECTS.include?(redirect_path)
      render plain: "Invalid redirect path. Only Mission Control (/admin/jobs) is accessible.", status: :bad_request
      return
    end

    # Decode and validate JWT
    payload = JsonWebToken.decode(token)
    user = User.find_by(id: payload[:user_id])

    unless user
      render plain: "User not found", status: :unauthorized
      return
    end

    # Mission Control requires admin role
    unless user.admin?
      render plain: "Access denied. Mission Control requires admin role.", status: :forbidden
      return
    end

    # Create Rails session (sign in via Warden/Devise)
    sign_in(user)

    # Redirect to Mission Control
    redirect_to redirect_path
  rescue JWT::DecodeError => e
    render plain: "Invalid or expired token", status: :unauthorized
  end
end
