# Product #3: Impact Translator

## Problem Statement

**The Self-Promotion Gap:** Developers build incredible things but struggle to communicate impact in ways that resonate with hiring managers, executives, or leadership during performance reviews. The gap manifests in several ways:

**Resume Writing is Painful:**

- "Merged 47 PRs" vs "Reduced API latency by 40% through caching optimization"
- Developers list tasks, not achievements
- Quantifying impact requires manual analysis of what actually shipped
- GitHub activity is rich data but translating it to compelling bullets takes hours

**Performance Reviews are Undersold:**

- Engineers can't remember accomplishments from 6 months ago
- "What did I even work on Q2?" requires digging through commit history
- Achievements hidden in technical jargon that managers don't understand
- Lack concrete metrics (reduced costs, improved performance, shipped features)

**Job Searching is Slow:**

- Every application requires customizing resume/cover letter
- Generic bullets don't highlight relevant experience
- No clear narrative of career progression
- LinkedIn profiles stale and underutilized

**Promotion Cases are Weak:**

- Can't articulate scope of impact for level progression
- Missing evidence of leadership, initiative, technical complexity
- Don't know how to "sell" accomplishments without feeling slimy

**Current Alternatives:**

- **Manual resume writing:** 4-8 hours per application cycle
- **Hiring resume writers:** $200-500, generic results, miss technical nuance
- **ChatGPT ad-hoc:** Inconsistent results, requires careful prompting
- **Performance review templates:** Generic, don't leverage actual GitHub data

## Core Value Proposition

**"Your GitHub commits are your career story - we translate them into impact."**

Impact Translator automatically analyzes GitHub activity to generate achievement-oriented narratives optimized for resumes, LinkedIn, performance reviews, and promotion packets. It transforms technical work into business-value language that resonates with non-technical audiences while maintaining technical credibility.

**Target Outcomes:**

- Reduce resume writing time from 4-8 hours to 30 minutes
- Generate performance review bullets in seconds, not hours
- Maintain always-updated LinkedIn profile without manual effort
- Build promotion cases with concrete evidence of impact

## Key Features

### Must-Have (MVP)

**1. GitHub Activity Analyzer**

- Connect GitHub account (OAuth)
- Analyze contributions across time periods:
  - Last 3 months (job applications)
  - Last 6 months (performance reviews)
  - Last year (annual reviews)
  - Last 2-5 years (promotion cases, career retrospectives)
- Extract meaningful data:
  - Repositories contributed to (with role context)
  - PRs merged (with impact assessment)
  - Issues resolved (with complexity analysis)
  - Code review activity (leadership signals)
  - Commits (with change magnitude analysis)
  - Language/tech stack distribution

**2. Achievement Bullet Generator**

- For each significant contribution, generate multiple bullet variations:
  - **Result-Oriented:** "Reduced API response time from 800ms to 320ms (60% improvement)"
  - **Scale-Focused:** "Optimized database queries serving 100K+ daily active users"
  - **Leadership-Angle:** "Led performance optimization initiative across 3 microservices"
  - **Technical-Depth:** "Implemented Redis caching layer with sub-100ms latency guarantees"
- Include quantifiable metrics wherever possible
- Use strong action verbs (led, architected, optimized, reduced, implemented)
- Tailor tone to context (resume vs LinkedIn vs review)

**3. Context Inference**

- Analyze PR descriptions, commit messages, and code changes to infer:
  - **Business impact:** What problem did this solve?
  - **Technical complexity:** How hard was this to build?
  - **Scale/scope:** How many users affected? Lines of code? Services touched?
  - **Collaboration:** Team contribution vs solo work
  - **Leadership indicators:** Mentoring, code reviews, architectural decisions

**4. Resume Builder (Targeted)**

- Paste job description → AI highlights relevant experience
- Auto-generates tailored resume bullets matching job requirements
- Suggests which projects/accomplishments to emphasize
- Reformats technical details for target audience:
  - **Technical role:** More implementation details
  - **Leadership role:** More team/business impact
  - **Startup:** Emphasize ownership and breadth
  - **Enterprise:** Emphasize scale and process

**5. Export Formats**

- Markdown (copy-paste to resume)
- Plain text (for ATS systems)
- JSON (for integrations)
- LinkedIn post format
- Performance review template (pre-filled with bullets)

### Nice-to-Have (Post-MVP)

**6. Continuous LinkedIn Sync**

- Auto-update LinkedIn profile as work happens
- Weekly/monthly digest: "Here's what you shipped this week"
- Suggest posts celebrating achievements ("Just shipped X feature!")
- Maintain activity timeline without manual updates

**7. Performance Review Assistant**

- Quarterly automated summaries sent to user's email
- Pre-filled review templates with accomplishments
- Peer contribution analysis (who did you help?)
- Growth trajectory visualization (complexity over time)

**8. Promotion Case Builder**

- Map accomplishments to level requirements
- Identify gaps in experience for target level
- Generate narrative arc showing progression
- Include specific evidence from GitHub activity

**9. Team Impact Analytics (Manager View)**

- Analyze entire team's contributions
- Generate team accomplishments for org reviews
- Identify high performers with evidence
- Spot knowledge silos and collaboration patterns

**10. Portfolio Website Generator**

- Auto-generated personal website showcasing projects
- Project cards with descriptions, tech stack, impact
- Continuous deployment (updates as you ship)
- Custom domain support

**11. Cover Letter Generator**

- Tailored to specific job postings
- Incorporates relevant GitHub projects
- Matches company culture from job description
- Multiple tone options (formal, conversational, creative)

**12. Interview Prep**

- Generate STAR-format stories from real projects
- "Tell me about a time you faced a technical challenge..."
- Pull specifics from actual GitHub activity
- Practice questions with AI interviewer

## UX Considerations

**Delivery Method:** Web Application (primary) + CLI Tool (power users) + Slack Bot (teams)

**Why Web App Primary:**

- Visual interface for browsing/editing bullets
- OAuth flow for GitHub connection
- Export options and formatting previews
- Account management and history

**Why CLI Tool:**

- Power users prefer terminal workflows
- Faster for quick queries: `impact-translate --period 3m --format resume`
- Scriptable and automatable
- No need to open browser for simple tasks

**Why Slack Bot:**

- Team managers want visibility into team accomplishments
- Weekly digest bots popular in eng teams
- Lower friction than visiting website
- Encourages regular engagement

**Key UX Principles:**

1. **Trust Through Transparency**
   - Show the GitHub activity that informed each bullet
   - Link directly to PRs/commits as evidence
   - Allow editing AI-generated text (never black-box)
   - Explain reasoning: "I emphasized performance impact because your commits show 60% latency reduction"

2. **Progressive Refinement**
   - Generate initial bullets automatically
   - User selects favorites to keep
   - Regenerate with different emphasis
   - Iteratively refine tone/style
   - "More technical" / "Less jargon" / "More metrics" buttons

3. **Context-Aware Generation**
   - Different outputs for different contexts (resume vs review vs LinkedIn)
   - Ask target role once, remember preference
   - Detect seniority level from activity (junior vs senior framing)
   - Adapt to industry (startup vs enterprise language)

4. **Privacy-First Design**
   - Clear explanation of what data is accessed (read-only GitHub activity)
   - Option to exclude specific repositories
   - No sharing of generated content without explicit permission
   - Easy account deletion with full data wipe
   - Work email only stored if user opts in (for team features)

5. **Time-Scoped Analysis**
   - Default to "last 3 months" (resume/job search focus)
   - Date picker for custom ranges
   - Visual timeline showing activity density
   - Highlight major accomplishments chronologically

**User Flows:**

**Flow 1: Resume Bullet Generation**

1. Sign in with GitHub
2. Select time period (last 3 months)
3. Review analyzed activity (PRs, commits, repos)
4. Click "Generate Resume Bullets"
5. Browse 15-20 generated bullets
6. Select favorites (checkboxes)
7. Refine selected bullets (more metrics, less technical, etc.)
8. Export to Markdown/plain text
9. Copy-paste into resume

**Flow 2: Job Application Customization**

1. Paste job description into input box
2. AI highlights relevant skills/experience from job posting
3. Show matching GitHub activity
4. Generate tailored bullets emphasizing matched skills
5. Suggest achievements to emphasize
6. Optional cover letter generation
7. Export application package

**Flow 3: Performance Review Prep**

1. User receives email: "Q3 performance review in 2 weeks"
2. Click link → pre-filled review form
3. See bullets for last 6 months
4. Edit/add context as needed
5. Export to PDF or share link with manager
6. Save for future reference (track progression)

**Flow 4: LinkedIn Profile Update**

1. One-time setup: Import current LinkedIn profile
2. AI compares GitHub activity to LinkedIn
3. Suggests updates: "You shipped X project but it's not on LinkedIn"
4. Generate profile sections: Experience, Skills, About
5. Preview formatted for LinkedIn
6. Copy-paste or use browser extension to auto-fill

**Design Mockup Descriptions:**

**Dashboard (Post-Login):**

- Activity summary cards:
  - "47 PRs merged" (last 3 months)
  - "12 repositories contributed to"
  - "156 code reviews given"
  - "23,450 lines of code added"
- Quick actions:
  - "Generate Resume Bullets"
  - "Prepare Performance Review"
  - "Update LinkedIn Profile"
  - "Build Promotion Case"
- Timeline visualization showing activity over time

**Bullet Generation Interface:**

- Left sidebar: Filter options (time period, repositories, bullet style)
- Center: List of generated bullets (cards)
  - Bullet text (editable)
  - Context button (expands to show source PRs/commits)
  - Style toggles (more metrics, less jargon, etc.)
  - Regenerate button
  - Select checkbox
- Right sidebar: Selected bullets (export preview)
  - Count (8 selected)
  - Export format dropdown
  - Copy button

**Activity Detail View:**

- Contribution graph (GitHub-style heat map)
- Repository breakdown (pie chart or list)
- Top accomplishments (AI-ranked by impact)
- Click any item → see detailed context
  - PR title, description, files changed
  - Commits included
  - Review comments given
  - Impact metrics inferred

## Freemium Strategy

**Free Tier:**

- ✅ Connect 1 GitHub account
- ✅ Analyze last 3 months of activity
- ✅ Generate 10 bullets per month
- ✅ Export to Markdown
- ✅ Basic resume formatting

**Paid Tier ($10/month individual):**

- ✅ Unlimited bullet generation
- ✅ Analyze full GitHub history (all time)
- ✅ Advanced export formats (JSON, ATS-optimized)
- ✅ Job description matching
- ✅ LinkedIn profile generation
- ✅ Performance review templates
- ✅ Cover letter generation
- ✅ Priority processing

**Pro Tier ($20/month):**

- ✅ All Paid features
- ✅ Promotion case builder
- ✅ Interview prep (STAR stories)
- ✅ Portfolio website generation
- ✅ CLI tool access
- ✅ Slack bot integration (personal)
- ✅ Continuous LinkedIn sync

**Team Tier ($50/month up to 10 users):**

- ✅ All Pro features
- ✅ Manager view (team impact analytics)
- ✅ Shared bullet library
- ✅ Team performance review assistance
- ✅ Slack bot for team channels

**Why This Works:**

- Free tier valuable for job seekers (10 bullets enough for one resume refresh)
- Natural upgrade when job searching intensifies (need >10 bullets)
- Monthly pricing attractive to job seekers (cancel after landing job)
- Team tier appeals to eng managers wanting better performance reviews
- Pro tier ($20) matches premium dev tool pricing (GitHub Copilot, ChatGPT Plus)

## Technical Considerations

**GitHub Data Collection:**

- OAuth scopes required:
  - `read:user` - User profile information
  - `repo` - Public and private repository access (only if user opts in)
  - `read:org` - Organization membership (for team features)
- Fetch via GitHub API:
  - User profile and contribution stats
  - Commits (author, message, stats, date)
  - Pull requests (title, description, files changed, reviews)
  - Issues (created, assigned, closed)
  - Code reviews (comments, approvals)
- Store minimal data (metadata only, not code contents)

**Privacy & Security Considerations:**

- **Critical:** Never store actual code, only metadata
- Encrypt sensitive data (GitHub tokens) at rest
- Rotate tokens regularly
- Allow users to exclude private repos
- GDPR/CCPA compliant (data export, deletion)
- SOC 2 compliance roadmap for enterprise

**AI Processing Pipeline:**

1. **Data Collection:** Fetch GitHub activity via API
2. **Preprocessing:** Cluster related commits/PRs into "projects"
3. **Impact Analysis:** For each project, extract:
   - Technical changes (what was built)
   - Business impact (problem solved, users affected)
   - Metrics (performance gains, error reductions, scale)
   - Complexity indicators (LOC, files, dependencies)
4. **Bullet Generation:** Pass project summaries to LLM with context:
   - User's role/seniority
   - Target format (resume, LinkedIn, review)
   - Tone preferences
   - Generate 3-5 variations per accomplishment
5. **Ranking:** Score bullets by impact, relevance, uniqueness
6. **User Refinement:** Allow editing, regeneration

**AI Strategy:**

- **Impact Analysis:** Claude Sonnet 4.5 (reasoning about technical → business value)
- **Bullet Generation:** GPT-4o (strong at marketing copy, concise bullets)
- **Job Matching:** GPT-4o (semantic similarity between skills and requirements)
- **Cover Letters:** Claude Sonnet 4.5 (longer-form, nuanced writing)

**Cost Estimation:**

- Profile analysis (initial): $0.10-0.30 per user
- Bullet generation (10 bullets): $0.02-0.05
- Job description matching: $0.01-0.03 per job
- Cover letter: $0.05-0.10
- At 100 active users generating 500 bullets/month: ~$15-25 in AI costs

**Caching Strategy:**

- Cache GitHub activity for 24 hours (reduce API calls)
- Cache generated bullets indefinitely (user's library)
- Invalidate cache on user request (refresh button)
- Pre-compute impact analysis during off-peak hours

**Database Schema:**

```
users
  - github_id, username, email, name
  - github_token (encrypted)
  - settings (JSONB: excluded_repos, tone_preference, seniority_level)
  - tier (free/paid/pro/team)
  - subscription_ends_at

github_activity
  - user_id, type (commit/pr/issue/review)
  - repository, title, body
  - stats (JSONB: additions, deletions, files_changed)
  - impact_score (calculated)
  - created_at, fetched_at

generated_bullets
  - user_id, activity_ids (array - links to source activity)
  - text, style (resume/linkedin/review)
  - edited (boolean - user modified?)
  - favorited (boolean - user saved?)
  - created_at

job_applications
  - user_id, company, role, description
  - tailored_bullets (JSONB - generated bullets for this job)
  - status (applied/interviewing/rejected/accepted)
  - applied_at

usage_metrics
  - user_id, action (generate_bullets/export/job_match)
  - count, date
  - tier_limit_reached
```

**Rate Limiting & Quotas:**

- Free tier: 10 bullet generations/month
- GitHub API: 5,000 requests/hour (unlikely to hit with caching)
- Implement usage tracking per user
- Soft limit warnings at 80% quota
- Upgrade prompts when hitting limits

**CLI Tool Implementation:**

- Written in Go or Rust (single binary, cross-platform)
- Authenticate via OAuth device flow (copy code to browser)
- Store token locally (~/.impact-translate/config)
- Commands:
  - `impact auth` - Authenticate with GitHub
  - `impact analyze --period 3m` - Analyze activity
  - `impact generate --format resume` - Generate bullets
  - `impact export --output resume.md` - Export to file
- Publish via Homebrew (macOS), apt/yum (Linux), Chocolatey (Windows)

---
