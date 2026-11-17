# ContractIQ Backend

Rails API-only backend for ContractIQ, aligned with the repository SRS.

## Requirements

- Ruby version in `.ruby-version`
- PostgreSQL 18 (or compatible), running locally
- Redis 7+ (only needed for Sidekiq/background jobs)
- Bundler

## Setup (Windows PowerShell)

From the repository root:

```powershell
cd backend
Copy-Item .env.example .env
notepad .env
```

In `.env`, set your local PostgreSQL username and password in `DB_USERNAME` and `DB_PASSWORD`. Keep the database name as `contractiq_development` unless you intentionally want a different one.

Generate a Rails secret from the `backend` directory:

```powershell
bin/rails secret
```

Copy the generated value into `SECRET_KEY_BASE` in `.env`. The app loads `.env` automatically before Rails starts. The real `.env` file is ignored by Git; only `.env.example` is committed.

Then install gems, create the database, run migrations, and start Rails:

```powershell
bundle install
bin/rails db:prepare
bin/rails server
```

`db:prepare` creates the development database if the PostgreSQL role has permission, then applies pending migrations. PostgreSQL must already be installed, running, and reachable at the host/port in `.env`. The PostgreSQL role must have permission to create the database on first setup.

### Sidekiq (optional background jobs)

Start Redis, then run this in a second terminal:

```powershell
cd backend
bundle exec sidekiq
```

Set `REDIS_URL` in `.env` if Redis is not using the local default `redis://localhost:6379/0`.

## API

All routes use `/api/v1`. Authentication uses a 24-hour HS256 bearer token.

- `POST /api/v1/auth/register`
- `POST /api/v1/auth/login`
- `DELETE /api/v1/auth/logout`
- `GET|POST /api/v1/workspaces`
- `GET|POST /api/v1/workspaces/:id`
- `GET|POST /api/v1/workspaces/:workspace_id/projects`
- `GET|POST /api/v1/projects/:project_id/services`

Send `Authorization: Bearer <token>`.

## Implementation status

This branch establishes the backend foundation: authentication, workspace membership, projects, API services, and initial analysis data models. Specification upload/validation, semantic comparison, Sidekiq workers, full RBAC policy enforcement, and RSpec coverage remain follow-up work. Do not treat the SRS MVP acceptance criteria as complete yet.
