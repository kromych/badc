---
name: milestone-close
description: Closing a badc release milestone -- no critical, high-severity, or miscompile issue left open in it, the rest moved to the next milestone, the agent queues drained, the release head gated, pushed, and green in CI, the documentation audited against the release's commits with doc/std-conformance.md first, and the open issues reviewed against the release head. Use when asked to close, finish, or wrap up a milestone or a release.
---

# Closing a milestone

The steps run in this order; each starts when the one before it is done. `M` is
the milestone being closed, `N` the next one.

## 1. No blocking issue stays open

- `gh issue list --milestone "M" --state open --label severity:critical` and the
  same with `severity:high` return nothing: each such issue is fixed and closed,
  or the milestone stays open.
- No miscompile is open, whatever its severity: a wrong-code report, a crash or
  hang of badc, a `memory-safety` issue, an open finding of the weekly csmith
  issue. `gh issue list --milestone "M" --state open --label bug` lists the
  candidates; read each. A fix follows the miscompile-triage skill.
- Run the same queries without `--milestone`: an open critical, high, or
  miscompile issue that blocks the release joins M first.

## 2. Move the rest

Create N if it does not exist (`gh api repos/kromych/badc/milestones -f
title="N"`), then move every open issue of M:

```sh
gh issue list --milestone "M" --state open --limit 500 --json number \
  --jq '.[].number' | while read n; do gh issue edit "$n" --milestone "N"; done
```

zsh does not split an unquoted variable into words, so a `for n in $list` loop
runs once with every number in one argument; read the list line by line.

## 3. Drain the queues

If agent queues are running, drain them as the queue-coordinator skill's
"Draining" section says and land what they finished. Nothing is in flight when
the release head is gated.

## 4. Push and CI

- Run the local checks, then gate the release head (the pre-push-validation
  skill; the queue-coordinator skill's `scripts/run_gate.sh` when queues share
  the boxes), and push.
- Close the issues the pushed commits fix: `close_fixed.sh` reads their
  `Fixes:` lines.
- Watch CI for the pushed SHA until every job passes. A failing job is fixed and
  the cycle repeats from the gate.

## 5. Documentation

Audit the documentation against the release's commits (`git log
origin/master..HEAD`): every statement about options, behavior, formats,
versions, and limits matches the code at the release head.

- `doc/std-conformance.md` is the normative document -- the
  implementation-defined choices, the divergences, the command-line
  compatibility, the extensions, and the roadmap -- and is audited first; then
  `README.md`, the rest of `doc/`, `demos/README.md`, `CONTRIBUTING.md`, and
  `.github/pages/`.
- The audit can run as parallel agents, one per group of documents, each
  proposing replacement text with its evidence. Verify every proposal against
  the code before writing it; an agent's claim is not evidence.
- A statement that turns out to describe a code defect (a diagnostic or help
  text that no longer holds) is fixed in the code too, or filed.
- The documentation commits go out like any other: local checks, gate, push,
  CI.

## 6. Review the open issues

For each issue that stays open, oldest first: whether it still applies at the
release head, and whether its repro or its requirement changed.

- One that no longer reproduces is closed with the command and the output that
  show it, on the platform it names.
- One that does takes a note: the head it reproduces at, the command and
  output, and any change to the repro or the requirement.
- One that cannot be decided (hardware, upstream timing, an ambiguous repro) is
  left as it is and listed.

The review can run as an agent that builds the release head in its own
worktree and keeps a ledger of the issues it handled, so a successor resumes
where it stopped.

## 7. Close

When M has no open issue: `gh api -X PATCH repos/kromych/badc/milestones/<number>
-f state=closed` (`gh api repos/kromych/badc/milestones --jq '.[] | "\(.number)
\(.title)"'` gives the number).
