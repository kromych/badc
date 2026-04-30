#include <stdio.h>
#include <stdlib.h>

// User-mode coroutine pool with work stealing.
//
// Two cooperative "workers" share a pool of fibonacci-shape tasks.
// Each task is a state machine that advances one step per tick:
// rather than blocking on a real recursion or thread switch, each
// `tick_task` call advances the fib(n) iteration by one and
// returns whether more work remains. That's enough to give the
// scheduler a yield point at every step.
//
// Each worker has its own deque of pending task ids:
//
//   * Own work pops from the FRONT (FIFO) -- recently-pushed tasks
//     stay near the back so a steal doesn't take a fresh task and
//     the owner doesn't fight for cache lines.
//   * Steals come from the BACK (LIFO) -- the back is the older
//     end of someone else's queue, so the steal grabs work that
//     the owner is least likely to touch next.
//
// This is the deque shape Cilk popularized: cheap own-work pop,
// expensive-but-rare steal. With two workers and a starting
// imbalance (worker 0 gets every task), worker 1 keeps going by
// stealing -- which is what we report at the end.
//
// Constraints driven by the c5 dialect: parallel int arrays
// instead of structs (no struct-array indexing), top-level
// declarations only, single-OS-thread cooperative scheduling
// (badc has no thread primitive that can pass per-thread state
// into a c5 callee). The "user-mode" framing is exactly that --
// the pool runs on one OS thread, but the tasks share the
// processor through cooperative yields rather than through
// pre-emption.

#define NUM_WORKERS    2
#define NUM_TASKS      12
#define DEQUE_CAP      32

// Per-task state machine for `fib(n)` via iteration. Each tick
// advances one step.
int *task_n;          // target index
int *task_step;       // steps already taken (0..n)
int *task_a;          // fib(step)
int *task_b;          // fib(step+1)
int *task_result;     // final fib(n) once done
int *task_done;       // 1 when finished
int *task_worker;     // which worker last ran the tick

// Per-worker deques. Flat int buffer, NUM_WORKERS * DEQUE_CAP
// long, indexed as `deque_buf[worker * DEQUE_CAP + slot]`.
int *deque_buf;
int *deque_head;      // [NUM_WORKERS]
int *deque_tail;      // [NUM_WORKERS]
int *deque_count;     // [NUM_WORKERS]

// Stats.
int *steal_count;     // [NUM_WORKERS]
int *tick_count;      // [NUM_WORKERS]

void deque_push(int worker, int task_id) {
    int base;
    int t;
    if (deque_count[worker] >= DEQUE_CAP) {
        printf("worker %d deque overflow\n", worker);
        exit(1);
    }
    base = worker * DEQUE_CAP;
    t = deque_tail[worker];
    deque_buf[base + t] = task_id;
    deque_tail[worker] = (t + 1) % DEQUE_CAP;
    deque_count[worker] = deque_count[worker] + 1;
}

// Pop from FRONT -- the owner's normal "next task" path.
int deque_pop_front(int worker) {
    int base;
    int h;
    int task_id;
    if (deque_count[worker] == 0) return -1;
    base = worker * DEQUE_CAP;
    h = deque_head[worker];
    task_id = deque_buf[base + h];
    deque_head[worker] = (h + 1) % DEQUE_CAP;
    deque_count[worker] = deque_count[worker] - 1;
    return task_id;
}

// Pop from BACK -- the steal path. A would-be-helper worker
// reaches across into another worker's deque and grabs its
// oldest entry.
int deque_pop_back(int worker) {
    int base;
    int t;
    int task_id;
    if (deque_count[worker] == 0) return -1;
    base = worker * DEQUE_CAP;
    t = (deque_tail[worker] - 1 + DEQUE_CAP) % DEQUE_CAP;
    task_id = deque_buf[base + t];
    deque_tail[worker] = t;
    deque_count[worker] = deque_count[worker] - 1;
    return task_id;
}

// Advance a task by one fib step. Returns 1 if more work remains,
// 0 if the task just finished. The caller decides whether to
// re-enqueue.
int tick_task(int task_id, int worker) {
    int next;
    task_worker[task_id] = worker;
    if (task_step[task_id] >= task_n[task_id]) {
        task_done[task_id] = 1;
        task_result[task_id] = task_a[task_id];
        return 0;
    }
    next = task_a[task_id] + task_b[task_id];
    task_a[task_id] = task_b[task_id];
    task_b[task_id] = next;
    task_step[task_id] = task_step[task_id] + 1;
    if (task_step[task_id] >= task_n[task_id]) {
        task_done[task_id] = 1;
        task_result[task_id] = task_a[task_id];
        return 0;
    }
    return 1;
}

// "Steal" attempt: pull one task from any other worker's deque
// (back end). Returns the stolen task id or -1 if everyone is
// empty.
int try_steal(int self) {
    int victim;
    int task_id;
    victim = 0;
    while (victim < NUM_WORKERS) {
        if (victim != self && deque_count[victim] > 0) {
            task_id = deque_pop_back(victim);
            if (task_id >= 0) {
                steal_count[self] = steal_count[self] + 1;
                return task_id;
            }
        }
        victim = victim + 1;
    }
    return -1;
}

// Are all worker deques empty?
int pool_idle() {
    int i;
    i = 0;
    while (i < NUM_WORKERS) {
        if (deque_count[i] > 0) return 0;
        i = i + 1;
    }
    return 1;
}

// Run one round-robin pass over the workers; return 1 if any
// worker did something useful, 0 if everyone was idle.
int scheduler_step() {
    int worker;
    int task_id;
    int more;
    int progress;
    progress = 0;
    worker = 0;
    while (worker < NUM_WORKERS) {
        if (deque_count[worker] == 0) {
            task_id = try_steal(worker);
        } else {
            task_id = deque_pop_front(worker);
        }
        if (task_id >= 0) {
            tick_count[worker] = tick_count[worker] + 1;
            more = tick_task(task_id, worker);
            if (more) deque_push(worker, task_id);
            progress = 1;
        }
        worker = worker + 1;
    }
    return progress;
}

int main() {
    int i;
    int total_ticks;
    int total_steals;

    // Allocate all the parallel arrays.
    task_n        = malloc(sizeof(int) * NUM_TASKS);
    task_step     = malloc(sizeof(int) * NUM_TASKS);
    task_a        = malloc(sizeof(int) * NUM_TASKS);
    task_b        = malloc(sizeof(int) * NUM_TASKS);
    task_result   = malloc(sizeof(int) * NUM_TASKS);
    task_done     = malloc(sizeof(int) * NUM_TASKS);
    task_worker   = malloc(sizeof(int) * NUM_TASKS);

    deque_buf     = malloc(sizeof(int) * NUM_WORKERS * DEQUE_CAP);
    deque_head    = malloc(sizeof(int) * NUM_WORKERS);
    deque_tail    = malloc(sizeof(int) * NUM_WORKERS);
    deque_count   = malloc(sizeof(int) * NUM_WORKERS);

    steal_count   = malloc(sizeof(int) * NUM_WORKERS);
    tick_count    = malloc(sizeof(int) * NUM_WORKERS);

    // Initialize tasks: task i computes fib(8 + i). Smaller indices
    // finish in fewer ticks, so the rebalancing kicks in mid-run.
    i = 0;
    while (i < NUM_TASKS) {
        task_n[i] = 8 + i;
        task_step[i] = 0;
        task_a[i] = 0;
        task_b[i] = 1;
        task_result[i] = 0;
        task_done[i] = 0;
        task_worker[i] = -1;
        i = i + 1;
    }

    // Initialize per-worker state. Push every task onto worker 0's
    // deque so worker 1 has to steal -- the imbalance is the whole
    // point of the demo.
    i = 0;
    while (i < NUM_WORKERS) {
        deque_head[i] = 0;
        deque_tail[i] = 0;
        deque_count[i] = 0;
        steal_count[i] = 0;
        tick_count[i] = 0;
        i = i + 1;
    }
    i = 0;
    while (i < NUM_TASKS) {
        deque_push(0, i);
        i = i + 1;
    }

    printf("coro_pool: %d tasks, %d workers, deque cap %d\n",
           NUM_TASKS, NUM_WORKERS, DEQUE_CAP);
    printf("           seed: every task on worker 0\n\n");

    // Run until idle.
    while (!pool_idle()) {
        scheduler_step();
    }

    // Print results.
    printf("results:\n");
    i = 0;
    while (i < NUM_TASKS) {
        printf("  task %2d: fib(%2d) = %-8d  finished on worker %d\n",
               i, task_n[i], task_result[i], task_worker[i]);
        i = i + 1;
    }
    printf("\nworker stats:\n");
    total_ticks = 0;
    total_steals = 0;
    i = 0;
    while (i < NUM_WORKERS) {
        printf("  worker %d: %d ticks, %d steals\n",
               i, tick_count[i], steal_count[i]);
        total_ticks = total_ticks + tick_count[i];
        total_steals = total_steals + steal_count[i];
        i = i + 1;
    }
    printf("  total:    %d ticks, %d steals\n", total_ticks, total_steals);

    free(task_n);
    free(task_step);
    free(task_a);
    free(task_b);
    free(task_result);
    free(task_done);
    free(task_worker);
    free(deque_buf);
    free(deque_head);
    free(deque_tail);
    free(deque_count);
    free(steal_count);
    free(tick_count);
    return 0;
}
