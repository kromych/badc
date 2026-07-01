// Returning an aggregate larger than 16 bytes (AAPCS64 x8 / System V
// memory class) from a function whose body is only `return <global>;` --
// no other local, no call. The callee saves the caller's indirect-result
// pointer into its result slot in the prologue and reads it on return.
// That slot is reached through a FunctionSsa field rather than an
// instruction, so the frame must still reserve it; otherwise the prologue
// either elides entirely (full-leaf) or omits the local area, leaving the
// pointer stored below sp where AAPCS64 grants no red zone.
typedef struct {
    unsigned int id;
    int a, b, c, d;
} Big; // 20 bytes

static Big g = {1, 2, 3, 4, 5};
static Big get_global(void) { return g; }

int main(void) {
    Big t = get_global();
    if (t.id != 1 || t.a != 2 || t.d != 5) return 1;
    // Immediate field access on the returned temporary.
    int s = get_global().id + get_global().d;
    if (s != 6) return 2;
    return 0;
}
