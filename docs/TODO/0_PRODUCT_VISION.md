# Repo Reconnoiter: Product Vision & Feature Specifications

**Last Updated:** November 13, 2025  
**Document Owner:** Jimmy (Director of Engineering)  
**Purpose:** Comprehensive product vision for AI-powered GitHub intelligence suite

---

## Executive Summary

Repo Reconnoiter is a suite of AI-powered developer productivity tools that solve the context-switching problem plaguing modern engineering teams. Built on a foundation of GitHub API integration and LLM intelligence, it transforms repository data into actionable insights that help developers understand code faster, review more effectively, and communicate their impact better.

**Core Insight:** Developers spend 60% of their time reading and understanding code. We make that time 10x more productive.

**Three Core Products:**

1. **PR Context Engine** - Automated context generation for code reviews
2. **Repository Learning Paths** - AI-generated navigation guides for unfamiliar codebases
3. **Impact Translator** - Converts GitHub activity into career-building narratives

**Go-to-Market Strategy:** Value-first freemium model targeting small engineering teams (5-20 developers) and individual developers. Initial focus on proving value and building user base, then optimize for break-even sustainability.

**Technical Foundation:** Rails API backend (brain + database) + Next.js frontend (user-facing) with distributed architecture allowing each product to use optimal delivery method.

## Cross-Product Synergies

While each product stands alone, they create powerful synergies when used together:

**1. Unified GitHub Connection**

- Single OAuth flow authenticates all products
- Shared repository access permissions
- Consistent data caching across products

**2. Learning → Context → Impact Pipeline**

- **Repository Learning Paths** helps new hires ramp up faster
- **PR Context Engine** helps them contribute meaningfully sooner
- **Impact Translator** captures their contributions for performance reviews
- Full developer lifecycle support

**3. Team Value Proposition**

- Engineering managers get holistic view:
  - Onboarding efficiency (Learning Paths)
  - Code review quality (PR Context)
  - Team performance (Impact Translator team view)
- Justifies $100-200/month team subscription

**4. Data Compound Effects**

- Repository analysis (Learning Paths) informs better PR context
- PR analysis informs better impact bullets (we know what shipped)
- Usage patterns improve all AI models over time

**5. Brand Coherence**

- "Repo Reconnoiter: AI-powered GitHub intelligence"
- Consistent design language across products
- Shared marketing funnel (try one product → discover others)

---

## Go-to-Market Strategy

### Phase 1: Product-Led Growth (Months 1-3)

**Goal:** Prove value with small user base, gather feedback, iterate rapidly

**Tactics:**

- Launch all 3 products simultaneously (MVP features only)
- Free tier generous enough to drive adoption
- Focus on personal network and engineering communities
- Content marketing: Technical blog posts about building with AI + GitHub API
- Show HN / Product Hunt launches for initial buzz

**Success Metrics:**

- 100 sign-ups across all products
- 20% activation (connected GitHub, used at least once)
- 5% week-2 retention (came back after first use)
- Qualitative feedback from 10+ users

### Phase 2: Niche Focus (Months 4-6)

**Goal:** Identify highest-traction product, double down, optimize for growth

**Tactics:**

- Analyze which product has best engagement/retention
- Focus marketing on that product's core use case
- Add 2-3 high-value features based on user feedback
- Begin monetization (convert free users to paid)
- Partnerships: Integrations with tools users already use (Slack, Linear, Notion)

**Success Metrics:**

- 500 total users (concentrated in winning product)
- 10-20 paying users ($200-400 MRR)
- 30-day retention >15%
- Net Promoter Score >30

### Phase 3: Scale & Expand (Months 7-12)

**Goal:** Reach break-even sustainability, build moat through data and network effects

**Tactics:**

- Invest in paid acquisition (calculated CAC/LTV)
- Launch team features (virality through org adoption)
- Build integrations marketplace (let others extend platform)
- Content flywheel: User-generated learning paths, shared bullets
- Community: Discord/Slack for users to share tips

**Success Metrics:**

- 2,000 total users
- 100 paying users ($2,000-3,000 MRR)
- Break-even or profitable (MRR > operational costs)
- Organic growth rate >10% month-over-month
- 1-2 enterprise customers (validation for future scaling)

### Distribution Channels

**Primary (High ROI):**

1. **Developer Communities:** Dev.to, Hacker News, Reddit (r/webdev, r/cscareerquestions)
2. **Content Marketing:** SEO-optimized blog posts ("How to write engineering resume", "Understanding codebases faster")
3. **GitHub Marketplace:** List as GitHub App (built-in discovery)
4. **Word of Mouth:** Referral program (give 1 month free for each referral)

**Secondary (Medium ROI):**
5. **YouTube:** Tutorials, demos, "building in public" content
6. **LinkedIn:** Career-focused posts for Impact Translator
7. **Podcasts:** Guest appearances on dev/career podcasts
8. **Conferences:** Small booth at regional eng conferences

**Tertiary (Experimental):**
9. **Paid Ads:** Google (high CPC but high intent), Reddit (cheaper, targeted)
10. **Influencer Partnerships:** Pay dev influencers for demos/reviews
11. **University Programs:** Free for students (build future customers)

### Competitive Positioning

**Against Established Players:**

- Don't compete with GitHub directly (position as enhancement layer)
- Narrower focus than Snyk/Socket (we do context, not security)
- More actionable than generic AI tools (domain-specific for devs)

**Unique Value Proposition:**

- "We make GitHub activity useful beyond just version control"
- "AI that understands your code AND your career"
- "Built by developers, for developers" (authentic positioning)

### Pricing Philosophy

**Break-Even Target:**

- Operational costs: ~$300-500/month (AI APIs, hosting, database)
- Break-even: 15-25 paying users at $20/month
- Profit goal: 100 users at $20/month = $2,000 MRR

**Willingness to Pay Research:**

- Survey early users: "What would you pay for this?"
- A/B test pricing ($10 vs $15 vs $20)
- Benchmark against comparable tools:
  - GitHub Copilot: $10/month (AI coding assistant)
  - ChatGPT Plus: $20/month (AI everything)
  - Linear: $8/user/month (dev tools)
  - Grammarly: $12/month (writing assistant)

**Pricing Evolution:**

- Launch: Free tier only (prove value)
- Month 3: Introduce paid tiers (test pricing)
- Month 6: Optimize pricing (adjust based on conversion data)
- Month 9: Add team tiers (expand ARPU)
- Month 12: Explore enterprise (if signal exists)

---

## Technical Architecture Overview

### System Components

**Frontend (Next.js):**

- React components for all 3 products
- Server-side rendering for SEO (landing pages)
- API routes for simple endpoints (webhooks, auth callbacks)
- Deployed on Vercel (free tier → Pro at scale)

**Backend (Rails API):**

- RESTful API for frontend consumption
- GitHub OAuth integration
- Webhook handlers (GitHub App events)
- Background job processing (Sidekiq)
- Database ORM (ActiveRecord with PostgreSQL)
- Deployed on Railway or Render ($50-100/month)

**Database (PostgreSQL):**

- User accounts and authentication
- Repository metadata and analysis results
- Generated content (bullets, learning paths, PR summaries)
- Usage tracking and analytics
- Hosted on Railway or Neon ($25-60/month)

**Cache Layer (Redis):**

- GitHub API response caching
- Session storage
- Job queue for Sidekiq
- Rate limiting counters
- Hosted on Upstash ($10-20/month)

**AI Services (External APIs):**

- OpenAI (GPT-4o, GPT-4o-mini)
- Anthropic (Claude Sonnet 4.5, Claude Haiku)
- Model router logic (use cheaper models when possible)

**File Storage (Optional):**

- S3 or Cloudflare R2 for large artifacts (repository archives)
- Only if needed for Learning Paths (can use GitHub API instead)

### API Architecture

**Endpoints (grouped by product):**

**PR Context Engine:**

- `POST /api/webhooks/github` - Receive PR events
- `GET /api/repos/:id/prs/:number/context` - Fetch generated context
- `POST /api/repos/:id/analyze` - Trigger manual analysis

**Repository Learning Paths:**

- `POST /api/repos/analyze` - Analyze new repository
- `GET /api/repos/:id/paths` - List available paths
- `GET /api/paths/:id` - Get specific path details
- `POST /api/paths/generate` - Generate custom path
- `PUT /api/paths/:id/progress` - Update user progress

**Impact Translator:**

- `POST /api/github/connect` - OAuth callback
- `GET /api/activity` - Fetch user's GitHub activity
- `POST /api/bullets/generate` - Generate bullets
- `PUT /api/bullets/:id` - Edit bullet
- `POST /api/export` - Export selected bullets

**Shared:**

- `POST /api/auth/github` - GitHub OAuth login
- `GET /api/users/me` - Current user profile
- `PUT /api/users/settings` - Update user settings
- `GET /api/usage` - User's quota/usage stats

### Security Considerations

**Authentication:**

- GitHub OAuth for all user authentication
- JWT tokens for API requests
- Refresh token rotation
- Session expiry (7 days)

**Authorization:**

- User can only access their own data
- Team admins can access team members' data (explicit consent)
- Repository access mirrors GitHub permissions (can't analyze repos user can't see)

**Data Protection:**

- Encrypt GitHub tokens at rest (Rails encrypted credentials)
- HTTPS everywhere (enforce SSL)
- Rate limiting per user (prevent abuse)
- SQL injection prevention (parameterized queries)
- XSS protection (sanitize user input)

**Privacy:**

- Clear data retention policy (delete after X days of inactivity)
- Easy account deletion (GDPR compliance)
- Audit logs for sensitive operations
- No sharing of user data with third parties
- AI vendors (OpenAI, Anthropic) don't train on our data (use zero-retention API)

### Monitoring & Observability

**Application Monitoring:**

- Error tracking: Sentry ($0-26/month)
- Performance monitoring: New Relic or Datadog (free tier)
- Uptime monitoring: UptimeRobot (free)

**Business Metrics:**

- Product analytics: PostHog (self-hosted free) or Mixpanel
- Track: Sign-ups, activations, feature usage, retention
- Dashboards for CAC, LTV, churn, MRR

**Cost Monitoring:**

- Track AI API spend per user
- Alert when costs exceed revenue (unit economics)
- Optimize expensive operations

---

## Success Metrics & KPIs

### Product-Specific Metrics

**PR Context Engine:**

- **Activation:** % of installs that receive first PR context
- **Engagement:** Avg PRs analyzed per repository per week
- **Value:** Time saved per review (survey-based)
- **Quality:** Thumbs up/down on context quality
- **Retention:** % of repositories still active after 30 days

**Repository Learning Paths:**

- **Activation:** % of sign-ups who complete first path
- **Engagement:** Avg paths completed per user
- **Completion Rate:** % who finish entire path (not abandon midway)
- **Value:** Time-to-productivity for new hires (before/after)
- **Retention:** % returning to complete second path

**Impact Translator:**

- **Activation:** % of GitHub connections who generate first bullet
- **Engagement:** Avg bullets generated per user
- **Edit Rate:** % of bullets edited (low = good AI quality)
- **Export Rate:** % who export bullets (intent to use)
- **Retention:** % who return for next job/review cycle

### Business Metrics

**Growth:**

- Monthly Active Users (MAU)
- Week-over-week growth rate
- Organic vs paid acquisition split
- Viral coefficient (referrals per user)

**Monetization:**

- Free → Paid conversion rate (target: 3-5%)
- Monthly Recurring Revenue (MRR)
- Average Revenue Per User (ARPU)
- Customer Lifetime Value (LTV)
- Customer Acquisition Cost (CAC)
- LTV:CAC ratio (target: >3:1)

**Engagement:**

- Daily Active Users / Monthly Active Users (DAU/MAU ratio)
- Feature adoption rates
- Time spent in product
- Actions per session

**Quality:**

- Net Promoter Score (NPS) (target: >30)
- Customer Satisfaction (CSAT) (target: >4/5)
- Churn rate (target: <5% monthly)
- Support ticket volume

---

## Risk Mitigation

### Technical Risks

**Risk: GitHub API Rate Limits**

- Mitigation: Aggressive caching, GraphQL usage, upgrade to Enterprise API if needed
- Fallback: Queue-based processing with delays

**Risk: AI API Costs Exceed Revenue**

- Mitigation: Usage caps per user, model routing, prompt optimization
- Fallback: Tier limits, overage charges

**Risk: AI Quality Inconsistent**

- Mitigation: Human review loops, user feedback integration, continuous prompt tuning
- Fallback: Hybrid AI + rule-based systems

**Risk: GitHub Changes API/Policies**

- Mitigation: Vendor diversification (support GitLab, Bitbucket)
- Fallback: Pivot to standalone git analysis

### Business Risks

**Risk: No Willingness to Pay**

- Mitigation: Survey early, test pricing early, pivot quickly
- Fallback: Focus on team/enterprise tiers

**Risk: Competitors Copy Features**

- Mitigation: Build defensible moat (data, community, integrations)
- Fallback: Niche down further

**Risk: User Growth Stalls**

- Mitigation: Multiple distribution channels, continuous experimentation
- Fallback: Focus on retention over acquisition

### Legal/Compliance Risks

**Risk: Data Privacy Violations**

- Mitigation: GDPR/CCPA compliance from day one, legal review
- Fallback: Geo-fence to US-only initially

**Risk: GitHub Terms of Service Issues**

- Mitigation: Read ToS carefully, stay within API guidelines
- Fallback: Direct git access (no API dependency)

---

## Roadmap (12-Month Plan)

### Q1 (Months 1-3): MVP & Validation

- ✅ Launch PR Context Engine MVP (GitHub App)
- ✅ Launch Repository Learning Paths MVP (Web App)
- ✅ Launch Impact Translator MVP (Web App)
- ✅ 100 total sign-ups across products
- ✅ Gather feedback from 20+ active users
- ✅ Iterate based on feedback

### Q2 (Months 4-6): Focus & Monetization

- ✅ Identify highest-traction product
- ✅ Add 3-5 high-value features to winning product
- ✅ Launch paid tiers (test pricing)
- ✅ 500 total users
- ✅ 10-20 paying customers ($200-400 MRR)
- ✅ Break-even on operational costs

### Q3 (Months 7-9): Scale & Polish

- ✅ Team features for all products
- ✅ Integrations (Slack, Linear, Notion)
- ✅ Content marketing engine (3-5 blog posts/month)
- ✅ 1,500 total users
- ✅ 50-75 paying customers ($1,000-1,500 MRR)
- ✅ Profitability

### Q4 (Months 10-12): Growth & Expansion

- ✅ Paid acquisition (if unit economics work)
- ✅ Community building (Discord/Slack)
- ✅ Partnership program (integrations marketplace)
- ✅ 3,000 total users
- ✅ 100-150 paying customers ($2,000-3,000 MRR)
- ✅ 1-2 enterprise customers
- ✅ Evaluate Series A potential vs bootstrapped profitability

---

## Conclusion

Repo Reconnoiter addresses a fundamental developer pain point: the context-switching tax. By leveraging AI to transform GitHub activity into actionable intelligence, we can save developers hours per week while building a sustainable SaaS business.

**Why This Works:**

1. **Real Problem:** Every developer faces context-switching, code comprehension, and career communication challenges
2. **Valuable Free Tier:** Generous enough to drive adoption, limited enough to encourage upgrades
3. **Multiple Revenue Streams:** Individual ($10-20/month), Team ($50-100/month), Enterprise ($200+/month)
4. **Defensible Moat:** Data compounds over time, integration depth creates switching costs
5. **Technical Feasibility:** Proven stack (Rails + Next.js), manageable AI costs, solo-developer buildable

**Success Criteria:**

- **Month 3:** 100 users, product-market fit signals
- **Month 6:** 20 paying users, break-even
- **Month 12:** 100+ paying users, $2K+ MRR, profitable

**Next Steps:**

1. Build PR Context Engine MVP (2 weeks)
2. Build Repository Learning Paths MVP (3 weeks)
3. Build Impact Translator MVP (3 weeks)
4. Soft launch to personal network (week 9)
5. Iterate based on feedback (weeks 10-12)
6. Public launch (week 13)

This is a portfolio-quality project that demonstrates product thinking, technical execution, and business acumen - exactly what hiring managers look for in engineering leaders. Let's build it.
