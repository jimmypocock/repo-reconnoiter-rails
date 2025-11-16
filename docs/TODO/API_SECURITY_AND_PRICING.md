🏗️ API Key Architecture: Current vs SaaS

Your Current Setup (Correct for Invite-Only)

Next.js Server → [One API Key] → Rails API
                  [User JWT per user]

Why this works:

- ✅ Small, trusted user base (invite-only whitelist)
- ✅ Not selling API access - users use your UI
- ✅ Simple: One API key to manage
- ✅ Secure: Compromising key alone doesn't help (need JWT too)
- ✅ Attacker needs BOTH key + hijacked user account

Limitation:

- Can't easily revoke access for one abusive user (they share the API key)
- Can't track costs per user for billing purposes

---
How do we properly calculate a cost for the SaaS so that we're not losing money?

When you're ready to discuss the enterprise SaaS subscription model, we can cover:

- Tiered pricing (Free/Pro/Enterprise with different limits)
- Usage-based billing (cost per analysis/comparison)
- Per-user API keys with usage tracking
- Stripe integration for payment processing
- Cost calculation (AI costs + infrastructure + margin)
- Admin dashboards for monitoring revenue/costs per user
- Webhook notifications for quota alerts
- Multi-tenancy patterns (organizations/teams)

It's a natural next step from what you've built - you already have the hard parts (auth, rate limiting, cost tracking, budget controls). Adding subscription tiers is mostly configuration + Stripe webhooks.

---
SaaS Setup (Per-User Keys)

For a paid SaaS where users pay for usage, you'd switch to:

User 1 → [API Key 1] → Rails API
User 2 → [API Key 2] → Rails API
User 3 → [API Key 3] → Rails API

Why this is better for SaaS:

1. Billing Attribution: Track exactly which user spent what

# In OpenAi service

def chat(...)

# Cost is attributed to the API key owner

  @current_api_key.user.charge_for_usage(cost)
end

1. Per-User Rate Limits: Free tier gets 5/day, Pro gets 100/day

# In AnalysisDeep

def user_can_create_today?(user)
  limit = user.subscription_plan.analysis_limit
  count_for_user_today(user) < limit
end

1. Easy Suspension: Revoke one key without affecting others
ApiKey.find_by(user: abusive_user).revoke!
1. Usage Dashboard: Show users their own API usage
GET /api/v1/usage → shows cost, requests, remaining quota

---
Short-Lived Tokens (Even More Secure)

This is what Stripe and AWS do:

User authenticates → Gets 15-min access token
                  → Refresh token for new access tokens

Pattern:

# User signs in

POST /auth/login
  → Returns: { access_token: "exp-15min", refresh_token: "exp-30days" }

# Every API request

GET /repositories
  Authorization: Bearer <access_token>  # Expires in 15 min

# When access token expires

POST /auth/refresh
  { refresh_token: "..." }
  → Returns: { access_token: "new-token-exp-15min" }

Why this is best for high-security SaaS:

- Compromised token expires in 15 minutes automatically
- Can't do much damage in 15 minutes (rate limits still apply)
- If user logs out, refresh token is revoked
- Standard OAuth2 pattern - well-understood

Downsides:

- More complex - need refresh token logic
- More requests (refresh every 15 min)
- Need to store refresh tokens securely

---
My Recommendation

For your current app (invite-only, free):

- ✅ Keep your current setup (shared API key + JWTs)
- ✅ Maybe add the pending cost tracking for race condition
- ✅ Monitor /admin/stats daily for abuse

If you go SaaS (paid, public signups):

Phase 1 (MVP - Easiest):

- Keep shared API key for Next.js server
- Add per-user rate limits based on subscription tier
- Track costs in user model for billing
- Good enough for launch - you can always migrate later

Phase 2 (Scale - Better):

- Issue per-user API keys on signup
- Each key has subscription tier attached
- Users can revoke/regenerate their own keys
- Display usage dashboard per user

Phase 3 (Enterprise - Best):

- Short-lived access tokens (15-60 min)
- Refresh token flow
- Webhook notifications for quota limits
- Multiple keys per user (dev, staging, prod)
