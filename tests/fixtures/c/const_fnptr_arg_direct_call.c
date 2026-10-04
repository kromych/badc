// snapshot-flags: -c -mcmodel=kernel -mindirect-branch=thunk-extern -mindirect-branch-register -mfunction-return=thunk-extern -fcf-protection=branch
// An always_inline retry loop takes an asm entry function as a
// function-pointer argument and calls through it, with a stack-pointer
// register variable as an asm operand on the way. The entry is an asm
// function without `endbr64`, so its address may appear only as a
// direct call's target: no `mov $entry_ret, %reg` for an out-of-line
// retry loop, no `call __x86_indirect_thunk_*` through a constant. Both
// callers below branch directly to `entry_ret` / `entry_saved_ret`: a
// call, or a jump where the caller returns the result unchanged.

typedef unsigned long u64;
struct call_args {
	u64 rcx, rdx, r8, r9;
};
typedef u64 (*entry_fn_t)(u64 fn, struct call_args *args);
u64 entry_ret(u64 fn, struct call_args *args);
u64 entry_saved_ret(u64 fn, struct call_args *args);
extern _Bool cache_dirty;
extern int nest_count;
register unsigned long stack_pointer asm("rsp");

static inline __attribute__((always_inline)) u64
call_marking_cache(entry_fn_t func, u64 fn, struct call_args *args)
{
	asm volatile("movb $1, %0" : "=m"(cache_dirty) : : "memory");
	return func(fn, args);
}

static inline __attribute__((always_inline)) u64
retry_call(entry_fn_t func, u64 fn, struct call_args *args)
{
	int retry = 10;
	u64 ret;

	do {
		asm volatile("addl $1, %0" : "+m"(nest_count) : : "memory");
		ret = call_marking_cache(func, fn, args);
		asm volatile("subl $1, %0" : "+m"(nest_count) : : "memory");
		asm volatile("call resched_thunk" : "+r"(stack_pointer));
	} while (ret == 0x8000020300000000ULL && --retry);
	return ret;
}

u64 read_field(u64 pa, u64 field, u64 *data)
{
	struct call_args args = { .rcx = pa, .rdx = field };
	u64 ret = retry_call(entry_ret, 26, &args);

	*data = args.r8;
	return ret;
}

u64 enter_entry(u64 pa, struct call_args *args)
{
	args->rcx = pa;
	return call_marking_cache(entry_saved_ret, 0, args);
}
