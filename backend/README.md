# ContractIQ Backend

Rails API-only backend for ContractIQ, aligned with the repository SRS.

## Requirements

- Ruby version in `.ruby-version`
- PostgreSQL 18 (or compatible)
- Redis 7+
- Bundler

## Setup (PowerShell)

From repository root:

```powershell
cd backend
bundle install
$env:DATABASE_URL = "postgresql://postgres:YOUR_PASSWORD@localhost:5432/contractiq_development"
$env:REDIS_URL = "redis://localhost:6379/0"
bin/rails db:prepare
bin/rails server
```

Run Sidekiq in another terminal:

```powershell
cd backend
$env:REDIS_URL = "redis://localhost:6379/0"
bundle exec sidekiq
```

Never commit real passwords or tokens.

## API

All routes use `/api/v1`. Authentication uses a 24-hour HS256 bearer token.

- `POST /api/v1/auth/register`
- `POST /api/v1/auth/login`
- `DELETE /api/v1/auth/logout`
- `GET|POST /api/v1/workspaces`
- `GET /api/v1/workspaces/:id`
- `GET|POST /api/v1/workspaces/:workspace_id/projects`
- `GET|POST /api/v1/projects/:project_id/services`

Send `Authorization: Bearer <token>`.

## Implementation status

This branch establishes the backend foundation: authentication, workspace membership, projects, API services, and initial analysis data models. Specification upload/validation, semantic comparison, Sidekiq workers, full RBAC policy enforcement, and RSpec coverage remain follow-up work. Do not treat the SRS MVP acceptance criteria as complete yet.
