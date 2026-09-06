// snapshot-flags: -c -mcmodel=kernel -mindirect-branch=thunk-extern -mindirect-branch-register -mfunction-return=thunk-extern -fcf-protection=branch
// The TDX `seamcall` shapes: an always_inline retry loop takes the
// SEAMCALL entry as a function-pointer argument and calls through it,
// with a stack-pointer register variable as an asm operand on the way
// (`preempt_enable`). The entry is an asm function without `endbr64`,
// so its address may appear only as a direct call's target: no
// `mov $__seamcall, %reg` for an out-of-line retry loop, no
// `call __x86_indirect_thunk_*` through a constant. Both callers
// below end up with `call __seamcall_ret` / `call __seamcall_saved_ret`.

typedef unsigned long u64;
struct tdx_module_args {
	u64 rcx, rdx, r8, r9;
};
typedef u64 (*sc_func_t)(u64 fn, struct tdx_module_args *args);
u64 __seamcall_ret(u64 fn, struct tdx_module_args *args);
u64 __seamcall_saved_ret(u64 fn, struct tdx_module_args *args);
extern _Bool cache_state_incoherent;
extern int preempt_count;
register unsigned long current_stack_pointer asm("rsp");

static inline __attribute__((always_inline)) u64
__seamcall_dirty_cache(sc_func_t func, u64 fn, struct tdx_module_args *args)
{
	asm volatile("movb $1, %0" : "=m"(cache_state_incoherent) : : "memory");
	return func(fn, args);
}

static inline __attribute__((always_inline)) u64
sc_retry(sc_func_t func, u64 fn, struct tdx_module_args *args)
{
	int retry = 10;
	u64 ret;

	do {
		asm volatile("addl $1, %0" : "+m"(preempt_count) : : "memory");
		ret = __seamcall_dirty_cache(func, fn, args);
		asm volatile("subl $1, %0" : "+m"(preempt_count) : : "memory");
		asm volatile("call preempt_schedule_thunk" : "+r"(current_stack_pointer));
	} while (ret == 0x8000020300000000ULL && --retry);
	return ret;
}

u64 tdh_vp_rd(u64 pa, u64 field, u64 *data)
{
	struct tdx_module_args args = { .rcx = pa, .rdx = field };
	u64 ret = sc_retry(__seamcall_ret, 26, &args);

	*data = args.r8;
	return ret;
}

u64 tdh_vp_enter(u64 pa, struct tdx_module_args *args)
{
	args->rcx = pa;
	return __seamcall_dirty_cache(__seamcall_saved_ret, 0, args);
}
