# Token Guard

**Spend tokens on evidence, not repetition.**

Token Guard is an adaptive execution skill for [OpenCode](https://opencode.ai/). It helps coding agents use smaller contexts, avoid repeated searches and reads, verify claims, and finish the whole task instead of stopping after the first patch.

No arbitrary output cap. No skipped tests just to save tokens. No invented savings percentages.

## Why Token Guard?

Agents often waste context by rediscovering the same file, rereading successful edits, repeating failed commands, or scanning a repository for a one-line change. Token Guard replaces that loop with a simple rule:

> Every tool call should answer a new question or move the task toward completion.

### What it does

- **Targets known edits directly** — goes straight to the supplied file, symbol, line, or diagnostic.
- **Reads once, with purpose** — captures enough context for a safe edit instead of repeatedly retrieving the same code.
- **Breaks repetitive loops** — forbids identical calls without a new question and changes strategy after failures.
- **Uses focused diagnostics** — prefers a failing test, compiler, linter, or clipped CLI error over large source reads.
- **Checks real evidence** — does not invent test results, config keys, token counts, or completion status.
- **Finishes the job** — silently tracks requested outcomes and continues through edit → verify → correct until complete or genuinely blocked.
- **Scales effort to risk** — a narrow fix gets a focused check; shared or risky changes can justify broader verification.

## Install

Requires OpenCode V2 and Git.

```sh
git clone https://github.com/artemqwer/token-guard.git
cd token-guard
./install.sh
```

The installer symlinks this directory into OpenCode's global skills directory, so updates only require `git pull`.

### Automatic activation

OpenCode advertises the skill automatically for relevant tasks. To explicitly instruct your agent to load it for every nontrivial task:

```sh
./install.sh --auto
```

Or add this line to `~/.config/opencode/AGENTS.md`:

```md
- For every nontrivial task (coding, debugging, research, configuration, or multiple steps), load and follow `token-guard` first. Simple stable answers need neither skills nor tools.
```

OpenCode reloads configuration automatically. No restart is needed.

### Project-only installation

```sh
mkdir -p /path/to/project/.opencode/skills
ln -s "$PWD" /path/to/project/.opencode/skills/token-guard
```

## Use

Just work normally. You can also invoke it explicitly:

```text
@token-guard fix the failing parser test without scanning unrelated files
```

Token Guard works best for coding, debugging, research, system configuration, and other multi-step work. It intentionally stays out of simple stable answers such as greetings or well-known definitions.

## Measure actual usage

Token Guard does not pretend to have a live context meter. Use OpenCode's real statistics:

```sh
opencode stats --days 0 --cost
opencode stats --days 7 --cost
opencode stats --days 7 --cost --json
```

For a useful comparison, run the same representative task in separate sessions with and without the skill. Compare total input, output, cache usage, completion quality, and tool-call loops. A single run is anecdotal; repeated representative tasks are evidence.

## What it deliberately does not do

- It does not enforce a live provider budget.
- It does not guarantee a fixed token reduction.
- It does not replace necessary verification with brevity.
- It does not ask for confirmation on routine reversible work.
- It does not require a runtime, package install, API key, or background process.

The entire skill is one readable [`SKILL.md`](SKILL.md) file. Audit it before installing; adapt it to your workflow if needed.

## Contributing

Issues and pull requests are welcome. The best improvements include a concrete repeated-agent behavior, a minimal prompt that reproduces it, and evidence that the change improves completion quality or reduces redundant work without hiding failures.

## License

[MIT](LICENSE) © 2026 Artem
