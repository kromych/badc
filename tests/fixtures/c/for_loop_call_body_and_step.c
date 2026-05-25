/* C99 6.8.5.3: the for-loop's iteration evaluates cond, body,
   step. The parser's bytecode layout emits step BEFORE body
   in linear PC order (cond, Bz end, Jmp body, step, Jmp cond,
   body, Jmp step). The walker emits SSA per block and must
   place step's insts before body's insts in `f.insts` so the
   post-merge resolver's order-zip between walker Inst::Call
   entries and bytecode Op::Jsr operands stays aligned.

   When walker emit order disagreed with parser layout order,
   the resolver paired each Inst::Call with the wrong Op::Jsr
   target. Both call sites in this fixture's loop would have
   targeted each other instead of themselves; the loop's
   counter would never advance to the terminating value.

   driver() returns 42 only when body's call (add_one) is
   target_pc-aligned with body's resolved target, and step's
   call (advance) is aligned with step's. */

static int add_one(int x)
{
    return x + 1;
}

static int advance(int x)
{
    return x + 1;
}

int driver(void)
{
    int sum = 0;
    for (int i = 0; i < 7; i = advance(i)) {
        sum = add_one(sum);
    }
    return sum * 6;
}

int main(void)
{
    return driver();
}
