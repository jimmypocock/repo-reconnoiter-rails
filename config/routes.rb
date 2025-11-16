Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # API routes (v1) - Conditional subdomain routing
  # Development:  localhost:3001/api/v1/comparisons
  # Production:   api.reporeconnoiter.com/v1/comparisons
  constraints(Rails.env.production? ? { subdomain: "api" } : {}) do
    scope path: (Rails.env.production? ? nil : "api"), module: "api" do
      namespace :v1, defaults: { format: :json } do
        # API root - shows available endpoints
        root to: "root#index"

        # Authentication endpoints
        post "auth/exchange", to: "auth#exchange"

        # Comparison endpoints
        resources :comparisons, only: [ :index, :show, :create ]
        get "comparisons/status/:session_id", to: "comparisons#status", as: :comparison_status

        # Repository endpoints
        resources :repositories, only: [ :index, :show ] do
          collection do
            post :analyze_by_url
          end
          member do
            post :analyze
          end
        end
        get "repositories/status/:session_id", to: "repositories#status", as: :repository_status

        # Profile endpoint (requires user auth)
        get "profile", to: "profile#show"

        # Admin endpoints (requires admin role)
        namespace :admin do
          get "stats", to: "stats#index"
        end

        # OpenAPI documentation endpoints
        get "openapi.json", to: "docs#openapi_json", as: :openapi_json  # For Swagger UI
        get "openapi.yml", to: "docs#openapi_yaml", as: :openapi_yaml   # For AI/programmatic access
      end
    end
  end

  # Swagger UI for interactive API documentation
  # Access at: /api-docs (development and production)
  mount Rswag::Ui::Engine => "/api-docs"

  # Session exchange for Next.js → Rails seamless authentication
  # Allows JWT-authenticated users to access Mission Control (/admin/jobs)
  get "session_exchange", to: "session_exchange#create"

  # OAuth callbacks for Mission Control login
  devise_for :users, skip: [ :registrations, :sessions, :passwords ],
             controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  # Custom sign out route (DELETE only)
  devise_scope :user do
    delete "users/sign_out", to: "devise/sessions#destroy", as: :destroy_user_session
  end

  # Admin routes (requires authentication + admin status)
  namespace :admin do
    # Mission Control for job monitoring
    authenticate :user do
      mount MissionControl::Jobs::Engine, at: "/jobs"
    end
  end
end
