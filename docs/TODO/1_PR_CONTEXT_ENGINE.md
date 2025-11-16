# Product #1: PR Context Engine

## Problem Statement

**The Context-Switching Tax:** Engineering leaders and senior developers constantly review code across multiple services, repositories, and domains. Opening a PR in an unfamiliar codebase requires 15-30 minutes of context gathering before meaningful review can begin:

- Reading through files to understand current behavior
- Checking commit history to understand why code exists
- Searching for related PRs and issues
- Understanding business logic and architectural patterns
- Identifying potential side effects

This tax compounds across teams. A Director of Engineering reviewing 10 PRs per week loses 2.5-5 hours purely on context gathering. Multiply across a team of 15 developers and you're burning 10-15 engineering hours weekly on preventable context-switching overhead.

**Current Alternatives Fall Short:**

- **GitHub's UI**: Provides raw diffs and file changes but no contextual intelligence
- **Reading commit messages**: Inconsistent quality, often missing the "why"
- **Asking the PR author**: Creates interruptions, delays reviews, doesn't scale
- **Manual code exploration**: Time-consuming, requires deep familiarity with codebase

## Core Value Proposition

**"Instant context for every code review, automatically."**

PR Context Engine analyzes pull requests using AI to generate rich contextual summaries that answer:

- **What does this code do currently?** (before the PR)
- **What will it do after this change?** (impact analysis)
- **Why does this change matter?** (business context)
- **What could break?** (risk assessment)
- **Where else might this affect?** (dependency impact)

**Target Outcome:** Reduce context-gathering time from 15-30 minutes to 2-3 minutes per PR, enabling faster reviews and better architectural decisions.

## Key Features

### Must-Have (MVP)

**1. Automated PR Summary Comment**

- Triggers when PR is opened or updated
- Posts as a GitHub bot comment within 30 seconds
- Includes:
  - Plain English summary of changes ("This PR refactors the payment processing flow...")
  - Before/after behavior comparison
  - Files modified with context (not just names)
  - Potential impact areas identified

**2. Current State Analysis**

- Analyzes existing code in modified files
- Explains what the code does currently
- Identifies patterns and architectural decisions
- Surfaces related functionality in other files

**3. Change Impact Assessment**

- Compares before/after states
- Identifies behavioral changes
- Flags breaking changes or API modifications
- Estimates risk level (Low/Medium/High)

**4. Related Context Discovery**

- Links to related PRs that touched same areas
- References relevant issues
- Identifies similar changes in codebase history
- Surfaces documentation or README sections

**5. Plain English Explanations**

- No jargon or assumptions of context
- Written for reviewers unfamiliar with the service
- Explains "why" not just "what"
- Suitable for non-technical stakeholders to understand changes

### Nice-to-Have (Post-MVP)

**6. Interactive Q&A**

- Ask follow-up questions in PR comments (@repo-bot "What happens if payment fails?")
- Context-aware responses based on PR and surrounding code
- Helps reviewers dig deeper without reading entire codebase

**7. Architecture Visualization**

- Generate call flow diagrams for complex changes
- Show before/after architecture
- Identify affected services in microservice architectures

**8. Reviewer Assignment Recommendations**

- Suggest best reviewers based on file expertise
- Identify domain experts from commit history
- Balance review workload across team

**9. Learning Mode**

- Track which questions reviewers ask frequently
- Proactively include that context in future summaries
- Adapt to team's specific needs over time

**10. Integration with CI/CD**

- Wait for tests to pass before generating full analysis
- Include test coverage changes in summary
- Flag if changes lack corresponding tests

## UX Considerations

**Delivery Method:** GitHub App (installed into repositories)

**Why GitHub App:**

- Native integration - no context switching
- Automatic triggers on PR events
- Familiar interface (GitHub comments)
- Easy team adoption (install once, everyone benefits)
- Permissions model aligned with GitHub's security

**Key UX Principles:**

1. **Non-Intrusive by Default**
   - Summary appears as collapsible comment
   - Doesn't clutter PR conversation
   - Can be hidden/minimized if not needed
   - Optional @mention for questions

2. **Scannable Information Hierarchy**
   - **TL;DR** section (2-3 sentences) at top
   - **Key Changes** section (bullet points)
   - **Detailed Analysis** section (expandable)
   - **Risk Assessment** (visual indicator: 🟢 Low / 🟡 Medium / 🔴 High)

3. **Actionable Insights**
   - Don't just describe changes - suggest review focus areas
   - "⚠️ Consider reviewing error handling in payment.rb:145"
   - "✅ No database migrations - safe to deploy anytime"
   - "🔍 Breaking change: API response format modified"

4. **Progressive Disclosure**
   - Show essentials immediately
   - Detailed technical analysis hidden behind "Show more"
   - Avoid overwhelming reviewers with information
   - Let them drill down as needed

5. **Consistent Formatting**
   - Use GitHub-flavored Markdown
   - Consistent section headers across all PRs
   - Visual indicators (emojis, badges) for quick scanning
   - Code snippets with syntax highlighting

**Configuration Options (per repository):**

- Toggle PR Context on/off
- Customize summary verbosity (Brief / Standard / Detailed)
- Exclude certain file types or directories
- Set risk threshold for highlighting (only flag Medium+ risks)
- Choose when to trigger (on open, on update, on review request)

**Mobile Considerations:**

- Summaries must be readable on mobile GitHub
- Collapsible sections crucial for small screens
- Avoid wide code blocks or tables
- Key information (TL;DR, risk) visible without scrolling

## Freemium Strategy

**Free Tier:**

- ✅ Unlimited PRs on public repositories
- ✅ 50 PR analyses per month on private repos
- ✅ Basic summary (TL;DR + Key Changes)
- ✅ Risk assessment
- ✅ 1 connected repository

**Paid Tier ($20/month per organization):**

- ✅ Unlimited PRs on private repositories
- ✅ Detailed analysis with impact assessment
- ✅ Interactive Q&A with bot
- ✅ Related context discovery
- ✅ Architecture visualizations
- ✅ Unlimited connected repositories
- ✅ Custom configuration per repo
- ✅ Priority processing (30s vs 2min for free)

**Enterprise Tier ($100/month, custom):**

- ✅ All Paid features
- ✅ SSO/SAML integration
- ✅ Dedicated support
- ✅ On-premises deployment option
- ✅ Custom integrations (Slack, Jira)
- ✅ Team analytics and insights

**Why This Works:**

- Free tier valuable enough to drive adoption (50 PRs/month = 2-3 per workday for 5-person team)
- Natural upgrade pressure when team hits limit
- Public repos free forever = good OSS citizen
- Price point ($20/org not per-user) competitive with GitHub Team ($4/user × 5 = $20)

## Technical Considerations

**GitHub App Permissions Required:**

- `pull_requests: read/write` - Read PR data, write comments
- `contents: read` - Access repository files for analysis
- `issues: read` - Link to related issues
- `repository: read` - Access commit history and repo metadata

**API Rate Limits:**

- GitHub: 5,000 requests/hour (authenticated)
- Use GraphQL to reduce call count (10-20x more efficient)
- Cache repository structure and file contents
- Incremental analysis (only analyze changed files)

**AI API Strategy:**

- **Initial analysis (large context):** Claude Haiku or GPT-4o-mini
- **Summary generation:** GPT-4o-mini (cost-effective)
- **Interactive Q&A:** Claude Sonnet 4.5 (higher quality for conversations)
- **Caching:** Use prompt caching for repository context (90% cost reduction)

**Cost Estimation per PR:**

- Small PR (1-5 files, 200 LOC): $0.02-0.05
- Medium PR (6-20 files, 500 LOC): $0.08-0.15
- Large PR (20+ files, 1000+ LOC): $0.20-0.40
- At 50 PRs/month average size: ~$5-8 in AI costs

**Database Schema (key tables):**

```
repositories
  - github_id, name, owner, installation_id
  - settings (JSONB: verbosity, excluded_paths, risk_threshold)
  - tier (free/paid/enterprise)

pull_requests
  - github_id, repository_id, number, title, body
  - analysis (JSONB: summary, risks, impact, related)
  - processed_at, cost_cents, model_used

pr_comments
  - pull_request_id, github_comment_id
  - content, posted_at

usage_metrics
  - repository_id, month, pr_count, cost_cents
  - tier_limit_reached_at
```

**Background Job Processing:**

- Use Sidekiq for async PR analysis
- Priority queue (paid > free)
- Retry logic for API failures
- Timeout protection (complex repos might take 2-3 min)

**Webhook Handling:**

- GitHub sends webhooks on PR events (opened, synchronized, review_requested)
- Validate webhook signatures
- Enqueue analysis job immediately
- Track processing time for SLA monitoring
