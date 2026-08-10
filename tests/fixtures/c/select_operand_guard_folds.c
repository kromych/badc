// A guard whose operand is a runtime `?:` between two constants is a
// compile-time constant: the comparison, and the mask, answer the same
// way for either arm, so the build-time-assert call is unreachable. C99
// 6.6 does not make such a value a constant expression, so this is an
// optimizer fold; the build-assert macro below is the shape the
// condition reaches it in -- a block-scope declaration of an undefined
// function, called when the condition holds. Linking is the assertion.

#define BUILD_BUG_ON(cond, tag)                                                                    \
    do {                                                                                           \
        extern void compiletime_assert_##tag(void);                                                \
        if (!(!(cond)))                                                                            \
            compiletime_assert_##tag();                                                            \
    } while (0)

// A comparison against the select: `flags` is 0 or 1, so `> 3` is false
// for either. The select is the call-site argument of an always_inline
// helper whose body carries the guard, so the guard only sees the two
// constants after the splice.
#define ENCODED_PAGE_BITS 3ul

static __attribute__((always_inline)) unsigned long encode_page(unsigned long page,
                                                                unsigned long flags) {
    BUILD_BUG_ON(flags > ENCODED_PAGE_BITS, 122);
    return flags | page;
}

static unsigned long batch[4];
static int rmap_delay_requested;

int add_page(unsigned long page);

int add_page(unsigned long page) {
    batch[0] = encode_page(page, rmap_delay_requested ? 1ul : 0ul);
    return (int)(batch[0] & ENCODED_PAGE_BITS);
}

// A mask over the select: the only non-constant term contributes bit
// 0x4 or nothing, and the mask selects neither bit, so the result is 0
// whichever arm runs.
#define VM_READ 0x1ul
#define VM_WRITE 0x2ul
#define VM_EXEC 0x4ul
#define VM_MAYREAD 0x10ul
#define VM_MAYWRITE 0x20ul
#define VM_MAYEXEC 0x40ul
#define VM_GROWSDOWN 0x100ul
#define VM_UFFD_WP 0x8000ul
#define VM_SOFTDIRTY 0x10000ul
#define VM_ACCOUNT 0x100000ul
#define READ_IMPLIES_EXEC 0x400000ul

struct task {
    unsigned long personality;
};

static struct task task_state;
static struct task *current = &task_state;

#define VM_DATA_DEFAULT_FLAGS                                                                      \
    (VM_READ | VM_WRITE | ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0ul) |           \
     VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
#define VM_STACK_FLAGS (VM_GROWSDOWN | VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT)
#define VM_STACK_INCOMPLETE_SETUP (VM_SOFTDIRTY | VM_UFFD_WP)

static unsigned long setup_stack_flags(void) {
    BUILD_BUG_ON(VM_STACK_FLAGS & VM_STACK_INCOMPLETE_SETUP, 771);
    return VM_STACK_FLAGS;
}

// A nested `?:` merges a select into a select, so the guard sees the
// union of what both levels can produce.
static int tier_selector;

static unsigned long tier_bits(void) {
    unsigned long v = tier_selector ? (rmap_delay_requested ? 1ul : 2ul) : 3ul;
    BUILD_BUG_ON(v > 3ul, 772);
    BUILD_BUG_ON(v == 0ul, 773);
    return v;
}

int main(void) {
    unsigned long base = VM_GROWSDOWN | VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC |
                         VM_ACCOUNT;
    task_state.personality = 0ul;
    if (setup_stack_flags() != base)
        return 1;
    task_state.personality = READ_IMPLIES_EXEC;
    if (setup_stack_flags() != (base | VM_EXEC))
        return 2;
    rmap_delay_requested = 0;
    if (add_page(0x1000ul) != 0)
        return 3;
    rmap_delay_requested = 1;
    if (add_page(0x1000ul) != 1)
        return 4;
    if (batch[0] != (0x1000ul | 1ul))
        return 5;
    tier_selector = 1;
    if (tier_bits() != 1ul)
        return 6;
    rmap_delay_requested = 0;
    if (tier_bits() != 2ul)
        return 7;
    tier_selector = 0;
    if (tier_bits() != 3ul)
        return 8;
    return 0;
}
