---
name: queue-coordinator
description: Coordinating badc work as several Claude agent queues in git worktrees -- briefing and resuming queues, the box locks, landing their commits on the release branch (fast-forward or cherry-pick with the snapshot hook), closing fixed issues, gating the combined head, and draining. Use when setting up or resuming agent queues, landing a queue's commits, deciding what a queue takes next, or running the gate while queues share the boxes.
---

# Coordinating agent queues

The coordinator owns the main repo's working tree, the release branch, GitHub writes
and the decisions; each queue agent owns one worktree and one box tree per box. The
agents follow the queue-agent skill (`.claude/skills/queue-agent/SKILL.md`).

## Durable state

Keep it in `.claude/queues/` (git-ignored), not in the conversation:
- `PROTOCOL.md`: the round's specifics only -- the base sha, the branch, the box
  remotes by name, the scratch path -- and a pointer to the queue-agent skill.
- `queue-<x>.md`: each queue's orders and log. Agents in isolated worktrees may be
  refused writes there; they put the log text in the report and the coordinator
  records it.
- `STATE.md`: the coordinator's log -- agent ids, landings, decisions with who made
  them, filed issues. It is the recovery point after a context cut.

## Briefing a queue

Spawn a general-purpose agent with `isolation: worktree`, in the background. The
brief pins the base sha and has the agent verify it first: a worktree can be cut from
an older commit. It names one item at a time, the issue numbers, the acceptance, and
what the agent must not do (push to origin, write to GitHub, edit CLAUDE.md or
settings). Resume an agent with SendMessage to its id; a new Agent call starts fresh.

Permissions: agent pushes to the box remotes need allow rules in
`.claude/settings.local.json` (`git push -f --no-verify <remote>
HEAD:refs/agents/queue-*`); the user saves that file, not the coordinator. The
permission classifier refuses branch deletion, settings edits and `git reset --hard`
in agent trees. When an agent reports a refusal, do not perform the refused action
for it; tell the user. A rebuilt commit is the agent's job: it checks out the head
detached and re-applies its commits (`cherry-pick -n` + `commit -F`).

## Deciding

Miscompiles first, then crashes and hangs, then the rest of the milestone.
Language-rule, ABI and policy choices (gcc vs clang vs MSVC behavior, defaults,
on/off-by-default diagnostics) go to the user with a recommendation; record the
answer on the issue and in STATE.md. A finding an agent reports becomes an issue with
the repro, the reference compilers' results and the cause, filed in the milestone it
belongs to.

## Landing

When every lane of a commit reports green, with each suite's announced test count
equal to its reported count:

```
bash .claude/skills/queue-coordinator/scripts/land.sh <sha>...   # oldest first
```

It fast-forwards when the list is exactly `HEAD..last`, otherwise cherry-picks each,
and stops on a conflict or on drift the post-commit snapshot hook leaves. A
snapshot-only conflict: take the commit's side (`git checkout --theirs`), continue,
and read the regenerated drift. Drift that is the combination of two landed changes
(a binding-index shift, a pass's effect on a fixture the other queue added) folds into
that commit with `git commit --amend --no-edit`; anything else goes back to the queue.

Then close what landed and tell the queues the new head:

```
bash .claude/skills/queue-coordinator/scripts/close_fixed.sh <round base> origin/<branch> <pr> local
```

## Gating and pushing

Gate the combined head before every push: the queues' lanes cover each series on its
own base, not their combination.

```
bash .claude/skills/queue-coordinator/scripts/run_gate.sh   # takes the box locks first
```

The user pushes (or asks the coordinator to); ask first. After the push, run
`close_fixed.sh ... pushed` for anything still open.

## Draining

Tell each queue to finish only the in-flight item, park the rest as `wip:` commits,
write its final note and push its refs; record the state in STATE.md.

## Lessons

- Every commit must pass `cargo build --locked --no-default-features --lib`; lanes do
  not run it, the pre-push hook does.
- A report carries every lane's counts; a rerun that covers some targets says which
  targets the earlier run covered at which hash.
- Lane counts far below their peers mean a truncated binary, not a pass.
- Never kill by pattern on shared hosts; only by pid, after checking the command line.
