# API root endpoint for discoverability
# Returns available endpoints and API information
# Root endpoint is public (no auth required)
#
module Api
  module V1
    class RootController < BaseController
      # Skip authentication for root endpoint (public access for API discovery)
      skip_before_action :authenticate_api_key!

      # GET /api/v1
      # Returns API version info and available endpoints
      def index
        render json: {
          message: "Welcome to RepoReconnoiter API v1",
          version: "v1",
          note: "This endpoint is public and does not require authentication",
          endpoints: {
            comparisons: {
              url: v1_comparisons_url,
              methods: [ "GET", "POST" ],
              description: "List and create repository comparisons",
              authentication: "Required"
            },
            repositories: {
              url: v1_repositories_url,
              methods: [ "GET", "POST" ],
              description: "List repositories and trigger deep analysis",
              authentication: "Required"
            },
            profile: {
              url: v1_profile_url,
              methods: [ "GET" ],
              description: "Get current user profile",
              authentication: "Required (User Token)"
            },
            documentation: {
              openapi_json: v1_openapi_json_url,
              openapi_yaml: v1_openapi_yaml_url,
              swagger_ui: rswag_ui_url,
              description: "Interactive API documentation and OpenAPI specs",
              authentication: "Not required"
            }
          },
          documentation_url: rswag_ui_url,
          authentication: {
            note: "Most endpoints require authentication. This root endpoint does not.",
            api_key: {
              header: "Authorization",
              format: "Bearer YOUR_API_KEY",
              description: "Required for all endpoints except root and documentation"
            },
            user_token: {
              header: "X-User-Token",
              format: "YOUR_JWT_TOKEN",
              description: "Required for user-specific endpoints (profile, creating comparisons/analyses)"
            }
          }
        }
      end
    end
  end
end
