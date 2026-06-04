# Documentation map for this repository

## Where to find what

### public/ -- Interface and behavior contracts
Sanitized documentation that other agents may read from outside this repo. Keep concise, accurate, free of implementation details.

Typical contents: interfaces.md, architecture.md, behavior.md, examples.md.

### internal/ -- Implementation reality
Detailed notes on how things actually work, why decisions were made, what is tricky. Read by humans and by executors in this repo.

Typical contents: design-decisions.md, gotchas.md, operations.md, dependencies.md.

### deprecated/ -- Archived old documentation
The pre-restructuring documentation, preserved here. Do not rely on. May contain useful historical context but treat as untrusted until verified against current code.

## Conventions

- Markdown only.
- Code blocks with language tags.
- Cross-reference by relative path.
- Update docs in the same commit as the code they describe.
- Mark deprecated sections with a header rather than deleting.
