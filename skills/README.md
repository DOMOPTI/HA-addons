# Skills

A skill is a procedural how-to, read by an agent mid-task and matched to the work
at hand. Skills are **lookup** docs: dense, terse, written for retrieval and
action, not for browsing.

## Format

One folder per skill (Anthropic's skill standard):

    skills/<skill-name>/SKILL.md

`<skill-name>` is lowercase-hyphens (e.g. `add-device-protocol`). Supporting
files (templates, scripts, examples) live beside `SKILL.md` in the same folder.
Each `SKILL.md` opens with YAML frontmatter, then a lookup-style body:

```yaml
---
name: <skill-name>           # lowercase-hyphens, max 64 chars
description: <what it does AND when to read it>    # third-person, max 1024 chars
scope: <repos / contexts the skill applies to>
---
```

## Read first

These cross-system skills govern how skills are written and how agents work.
Read the relevant one before you start; do not restate them here.

For working with the user and managing uncertainty across all tasks:

- `optim-on-iac/cross-system/skills/cooperating/SKILL.md` — uncertainty levels, when to stop and ask, IP discipline, handling correction.

For authoring or editing skills:

- `optim-on-iac/cross-system/skills/authoring-docs/SKILL.md` — the doc standard.
- `optim-on-iac/cross-system/skills/verifying-docs/SKILL.md` — the verification pass to run before declaring a skill done.

## Authoring a skill

Skills emerge from repeated patterns: if you give an agent the same instructions
twice, write the skill the third time. Keep it concrete and testable, reference
this repo's actual conventions, and follow the standard above.

## Index

(no skills in this repo yet — added as patterns emerge)
