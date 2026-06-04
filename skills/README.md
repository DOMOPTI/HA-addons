# Skills

A skill is a procedural document explaining how to perform a specific kind of task in this repository. Skills are matched by task type and read by agents at the start of relevant work.

## Skill file naming

SKILL_<task-type>.md -- e.g., SKILL_add-feature.md, SKILL_fix-bug.md, SKILL_release.md.

## Skill structure

Every skill file should have:

- Header line: # SKILL: <name>
- "When to use this skill" section: bullets describing task types/keywords for matching.
- "Prerequisites" section: other docs to read first.
- "Procedure" section: numbered explicit steps, with file:line references where applicable.
- "Verification" section: how to confirm success.
- "Common mistakes" section: traps to avoid.

## How to author a skill

Skills should emerge from repeated patterns. If you find yourself giving the same instructions to an agent twice, write a skill the third time.

A good skill is concrete, testable, and references this repo's actual conventions.

## Index

(no skills yet -- they will be added as patterns emerge)
