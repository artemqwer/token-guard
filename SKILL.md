---
name: Token Guard
description: Adaptive token-efficient execution with anti-hallucination checks. Use for coding, debugging, research, configuration, and multi-step tasks, and whenever the user asks to save tokens or reduce context. Minimize tool output and repetition without sacrificing correctness or required verification.
---

# Token Guard

Optimize evidence gathering, not answer quality. User requirements, project instructions, necessary verification, and honest uncertainty override economy.

## Drive the task autonomously

- Silently extract every explicit requirement and necessary acceptance check. Track them mentally; do not create todo files or narrate routine plans.
- Choose the next action from current evidence, execute it, and update that checklist. Keep working until all requirements are satisfied or an external decision/credential/irreversible action genuinely blocks progress.
- Before finishing, check coverage: requested outcomes, changed files, focused verification, and known failures. A known failure means continue fixing, not write a success summary.
- Do not impose an arbitrary tool-call budget. Save calls through better targeting, not by abandoning verification or leaving work partial.
- For reversible work, act without routine confirmation. Ask only when blocked by missing consequential information or risk.

## Use the cheapest sufficient workflow

- Answer known stable questions directly. Use tools for files, system state, current facts, or tasks requiring action.
- Infer from context; ask only when necessary to proceed safely. Do not print plans unless requested.
- Locate with `grep`, `glob`, symbols, LSP/AST, or diagnostics before reading. Read only the target and enough surrounding context to edit safely.
- For bugs, prefer a focused failing test, compiler, linter, or clipped CLI error over large source reads.
- Reuse established facts. Never reread unchanged files, repeat successful searches, or refetch the same large output.
- Run independent lookups in parallel. Use subagents only for broad or independent work; request conclusions with essential paths/lines.
- Bound noisy output with filters/tails but preserve exit status (`set -o pipefail` for piped checks in POSIX shells) and diagnostic lines.
- Stop when evidence is sufficient. Never repeat an identical search/read hoping for a different result; each call must answer a new question. After two unsuccessful strategies, report the blocker or change approach.

## Single-pass targeted edits

- If the user or diagnostics identify the file, line, symbol, or failing test, go straight there. Do not run exploratory `grep`/`glob` just to rediscover a known target.
- Read the target once with enough context for a safe edit. Remember paths, symbols, diagnostics, and edit results instead of repeatedly retrieving them.
- A successful edit tool result confirms the write; do not reread solely to admire or reconfirm it. Read again only if later work needs different context or the result is uncertain.
- On failure, use the new error to choose a different action. Do not cycle through the same search, read, test, or fix.

## Change, verify, and finish

- Make the smallest requested change; no speculative abstractions, reformatting, or unrelated cleanup.
- Patch only affected locations. Assume an experienced developer; when chat needs code, show a minimal diff/snippet rather than a full file.
- Run the narrowest meaningful verification. Expand only for shared/risky changes or evidence of regression.
- Continue through edit → focused verification → correction until every requested subtask is complete or genuinely blocked. Do not stop after the first patch, a plan, or partial implementation.
- If verification fails, fix the reported failure and rerun only affected checks. Never claim unrun checks passed or that they cover more than they do.

## Do not hallucinate to save tokens

- Ground claims about files, commands, tests, system state, and external/current facts in tool output or primary sources.
- Never invent paths, APIs, config keys, URLs, output, token counts, savings, or completion status.
- State material uncertainty or missing verification briefly. Keep caveats that affect user decisions.

## Output and monitoring

- Match the user's language and format. Default to result, changed paths, and essential verification; skip intros, repeated plans, and generic advice.
- A skill has no live context meter. For real OpenCode totals run `opencode stats --days 0 --cost`; add `--json` for machine-readable output or use `--days 7` for a week. Call these historical totals, not live budgets or guaranteed savings.
- Compact only long sessions; retain goal, changed files, verified results, and unresolved issue.
