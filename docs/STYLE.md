# Project Style & Conventions

A quick guide to keep this codebase clean, decoupled, and sane as the project scales.

## 1. Architecture & Design Patterns

- **Data in Resources:** State belongs in `Resource` scripts (e.g., `ProgressionData`, `CollectionData`), not global singletons or player nodes. Keep data separate from scene logic.
- **Reactive Setters:** Use property setters on state resources to guarantee signals fire automatically on mutation. No manual signal triggers scattered across random gameplay scripts.
- **Component Decoupling:** Nodes communicate strictly via signals and methods. Components never directly poke at or mutate sibling/parent internal state.

## 2. Naming Conventions

- **Classes / Nodes / Scripts:** `PascalCase` (e.g., `ProgressionData.gd`, `TrashCan.tscn`)
- **Variables / Methods / Signals:** `snake_case` (e.g., `max_trash_capacity`, `coins_changed`)
- **File Paths:** Lowercase with hyphens or underscores, grouped logically by domain (`entities/player/`, `objects/trash/`, `resources/`).

## 3. Git Commit Workflow

We stick strictly to Conventional Commits so the history reads like a clean changelog.

- **Format:** `type(scope): subject`
- **Types:** 
  - `feat` (new features or gameplay systems)
  - `refactor` (code restructuring without behavior change)
  - `fix` (bug fixes)
  - `chore` (housekeeping, assets, config)
- **Subject Rules:** Use the imperative mood, lowercase, no period at the end (e.g., `feat(progression): add ProgressionData resource`).
- **Body:** Use multi-line bullet points `-` when a commit touches multiple systems or involves a deliberate architectural choice.