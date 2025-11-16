# Product #2: Repository Learning Paths

## Problem Statement

**The Codebase Overwhelm Problem:** Developers frequently encounter unfamiliar repositories - joining a new team, contributing to open source, reviewing architecture during M&A due diligence, or simply working in a microservices environment with dozens of services. The current approach is chaotic:

- **Random file exploration:** grep/search for keywords, hope to find relevant code
- **README diving:** Often outdated, rarely explains architecture comprehensively
- **"Just read everything":** Unrealistic for 50K+ LOC repositories
- **Ask a teammate:** Interrupts others, creates knowledge bottlenecks, doesn't scale

**The Real Cost:** A senior developer joining a new team spends 2-4 weeks before feeling productive. Engineering leaders evaluating acquisition targets spend hours manually tracing code flows. New contributors to open source projects abandon after failing to find entry points.

**Current Alternatives:**

- **Documentation:** Rarely explains *how* to read the code, only *what* it does
- **Code tours (VS Code extension):** Manual creation, high maintenance burden
- **Onboarding docs:** Quickly become outdated, focus on setup not comprehension
- **Architecture diagrams:** Static, don't guide actual code reading

## Core Value Proposition

**"AI-generated guided tours through any codebase."**

Repository Learning Paths analyzes repository structure, code relationships, and architectural patterns to generate step-by-step reading guides tailored to specific learning goals:

- **"Show me how authentication works"** → 6-file reading path with explanations
- **"How does data flow from API to database?"** → Request lifecycle guide
- **"Where should I start contributing?"** → Beginner-friendly entry points
- **"What changed in v2.0?"** → Migration guide for version differences

**Target Outcome:** Reduce time-to-productivity in unfamiliar codebases from 2-4 weeks to 2-4 days by providing structured learning paths instead of chaotic exploration.

## Key Features

### Must-Have (MVP)

**1. Automatic Architecture Analysis**

- Scans repository to identify:
  - Entry points (main.js, app.rb, API routes)
  - Core business logic vs infrastructure code
  - Data models and database interactions
  - External dependencies and integrations
  - Test coverage patterns
- Builds dependency graph of file relationships
- Identifies architectural patterns (MVC, microservices, event-driven, etc.)

**2. Pre-Generated Learning Paths**
Create standard paths for common learning goals:

- **"Quick Start"** (3-5 files): Understand what this repo does in 30 minutes
- **"Authentication & Authorization"**: Complete auth flow
- **"Data Flow"**: Request → Processing → Response → Database
- **"Core Business Logic"**: Where domain logic lives
- **"Testing Strategy"**: How tests are organized and run
- **"Deployment & Infrastructure"**: How code gets to production

**3. Interactive File Navigator**

- Visual representation of learning path
- Click through files in recommended order
- Inline explanations within file context
- "Why am I reading this file?" context at top
- "What should I look for?" guidance
- "Next: Read [filename] to understand..." navigation

**4. Plain English Explanations**
For each file in the path:

- **Purpose:** What role this file plays in the system
- **Key Concepts:** Important functions/classes to understand
- **Read First:** Which lines/sections to focus on
- **Skip:** Boilerplate or irrelevant sections
- **Connects To:** Related files and why they matter

**5. Progress Tracking**

- Mark files as "read" to track progress
- Resume where you left off
- Estimated time to complete path
- Quiz/verification questions (optional)

### Nice-to-Have (Post-MVP)

**6. Custom Path Generation**

- Natural language queries: "Show me how payments are processed"
- AI generates custom path on demand
- Adapts to your role (frontend dev vs backend dev gets different paths)

**7. Team Knowledge Integration**

- Incorporate team's implicit knowledge
- "Sarah usually reviews auth code" → suggest Sarah as mentor
- Highlight files with high change frequency (maintenance hotspots)
- Show "Bus Factor" risk areas (only one person knows this code)

**8. Multi-Repository Paths**

- Trace flows across microservices
- "Show me checkout flow across all services"
- Generate cross-repo dependency maps

**9. Diff-Based Paths**

- "What changed between v1.0 and v2.0?"
- Migration guides for major refactors
- Breaking changes highlighted with upgrade paths

**10. Video Walkthroughs**

- AI-narrated video tours of complex flows
- Screen recording-style with code highlighting
- Shareable links for team onboarding

**11. Onboarding Workflows**

- Day 1: Run the app locally
- Day 2: Make first contribution (good first issues)
- Week 1: Understand core architecture
- Month 1: Deep dive into specialized areas
- Auto-generated based on repository complexity

## UX Considerations

**Delivery Method:** Web Application (standalone) + GitHub App (integration points)

**Why Web App Primary:**

- Complex interactive UI (not feasible in GitHub comments)
- Visualization and navigation require rich interface
- Progress tracking across sessions
- Supports logged-out users (public repos)

**Why GitHub App Secondary:**

- Install to access private repositories
- Deep link from GitHub repo page to learning path
- Sync with GitHub permissions (see only repos you have access to)

**Key UX Principles:**

1. **Visual Learning Path Map**
   - Start with visual overview showing entire path
   - Boxes representing files connected with arrows
   - Progress indicator (3 of 8 files completed)
   - Estimated time remaining
   - Can jump ahead or go back

2. **In-Context Code Reading**
   - Show file contents within the app (syntax highlighted)
   - Inline annotations explaining key sections
   - Highlight specific lines relevant to current learning goal
   - Side-by-side view: code on left, explanation on right

3. **Minimal Cognitive Load**
   - One file at a time (no overwhelming multi-panel views)
   - Clear "Next" button to advance
   - Breadcrumbs showing position in path
   - Can bookmark/save position to return later

4. **Adaptive Difficulty**
   - Beginner mode: More explanation, slower pace
   - Advanced mode: Faster pace, assumes knowledge
   - Let users toggle explanation verbosity

5. **Mobile-Friendly (Read-Only)**
   - Path overview works on mobile
   - Code reading challenging on small screens (acceptable limitation)
   - Save position to continue on desktop

**User Flows:**

**Flow 1: Anonymous User Exploring Public Repo**

1. Land on repoReconnoiter.com
2. Enter GitHub repo URL (e.g., github.com/rails/rails)
3. Select learning goal from pre-generated paths
4. Read through guided tour
5. Prompt to sign in to save progress (optional)

**Flow 2: Authenticated User with Private Repos**

1. Sign in with GitHub OAuth
2. Install GitHub App to access private repos
3. Browse own repositories or team repos
4. Select repo → choose/generate path
5. Track progress, mark files complete
6. Return anytime to resume

**Flow 3: Team Onboarding**

1. Engineering manager generates custom onboarding path
2. Share link with new hire
3. New hire follows interactive guide
4. Manager sees progress dashboard
5. Triggers discussions at key milestones

**Design Mockup Descriptions:**

**Homepage:**

- Hero: "Stop grep-ing. Start learning." with demo GIF
- Input box: "Paste any GitHub URL to explore"
- Example repos below (Rails, React, popular OSS)
- Social proof: "X developers learned Y repositories this month"

**Learning Path Selection:**

- Repository header (name, description, stars, language)
- Grid of pre-generated paths (cards with icons)
  - 🚀 Quick Start (30 min)
  - 🔐 Authentication (45 min)
  - 💾 Data Flow (1 hour)
  - 🧪 Testing Strategy (30 min)
- "Generate custom path" button at bottom

**Reading Interface (Split View):**

- **Left Sidebar (20%):** Path map, progress, navigation
- **Center (50%):** File contents with syntax highlighting
- **Right Panel (30%):** AI explanations, annotations, next steps
- **Top Bar:** File name, breadcrumbs, time estimate
- **Bottom Bar:** Previous/Next buttons, mark complete checkbox

## Freemium Strategy

**Free Tier:**

- ✅ Unlimited public repositories
- ✅ Pre-generated learning paths (6 standard paths)
- ✅ Progress tracking (requires sign-in)
- ✅ Up to 3 private repositories
- ✅ Export path as Markdown

**Paid Tier ($15/month individual, $50/month team up to 10 users):**

- ✅ Unlimited private repositories
- ✅ Custom path generation (natural language queries)
- ✅ Advanced analysis (multi-repo paths, diffs)
- ✅ Team collaboration features
- ✅ Onboarding workflow templates
- ✅ Analytics (time saved, completion rates)
- ✅ Priority path generation (instant vs 5-min wait)

**Enterprise Tier ($200/month, custom):**

- ✅ All Paid features
- ✅ SSO/SAML
- ✅ Self-hosted deployment
- ✅ Custom branding
- ✅ API access for integrations
- ✅ Dedicated support

**Why This Works:**

- Free tier incredibly valuable for OSS exploration (viral growth mechanism)
- Natural upgrade when needing private repo access
- Team pricing encourages org-wide adoption
- Individual price point ($15) similar to ChatGPT Plus (familiar anchor)

## Technical Considerations

**Repository Analysis Pipeline:**

1. **Clone/Fetch Repository** (shallow clone, limited depth)
2. **File Classification** (AI categorizes by role: routes, models, tests, etc.)
3. **Dependency Mapping** (static analysis of imports/requires)
4. **Pattern Recognition** (identify framework, architectural style)
5. **Generate Base Paths** (6 standard paths using templates + AI customization)
6. **Cache Results** (paths valid until major repo changes)

**AI Strategy by Feature:**

- **Architecture Analysis:** Claude Sonnet 4.5 (high reasoning for structure understanding)
- **Path Generation:** GPT-4o (good balance of quality and speed)
- **Explanations:** GPT-4o-mini (cost-effective for text generation)
- **Custom Queries:** Claude Sonnet 4.5 (conversational, handles complex requests)

**Cost Estimation per Repository:**

- Small repo (<10K LOC): $0.10-0.30 initial analysis
- Medium repo (10K-50K LOC): $0.40-0.80 initial analysis
- Large repo (50K+ LOC): $1.00-2.50 initial analysis
- Paths cached indefinitely (only regenerate on major changes)
- Custom path generation: $0.05-0.15 per query

**Caching Strategy:**

- Cache repository analysis for 7 days (or until new commits)
- Invalidate cache on push events (GitHub webhook)
- Store file contents in CDN for fast loading
- Pre-generate paths for popular public repos (Rails, React, etc.)

**Database Schema:**

```
repositories
  - github_id, name, owner, full_name
  - analyzed_at, analysis (JSONB: structure, entry_points, patterns)
  - last_commit_sha (detect changes)
  - stars, language, size_kb

learning_paths
  - repository_id, name, slug
  - type (standard/custom)
  - files (JSONB array: [{path, purpose, key_concepts, order}])
  - estimated_minutes
  - generated_at

user_progress
  - user_id, learning_path_id
  - completed_files (array of file paths)
  - started_at, last_activity_at
  - completed_at

usage_analytics
  - repository_id, path_id
  - views, completions, avg_completion_time
  - user_feedback (helpful/not helpful)
```

**GitHub API Usage:**

- Fetch repository metadata (1 call)
- Download repository archive (1 call)
- Get file contents individually (N calls, batched)
- Alternative: Use git clone (faster but requires server storage)

**Performance Targets:**

- Initial analysis: <2 minutes for medium repos
- Path generation: <30 seconds for standard paths
- Custom path generation: <60 seconds
- Page load time: <3 seconds (cached paths)

---
