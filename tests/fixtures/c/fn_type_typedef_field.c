// A struct field declared as a pointer to a function-type typedef that
// returns a struct, called through the field. The function-type typedef
// already encodes one pointer level, so the call must strip the full
// chain to yield the struct return type, not an intermediate pointer.
// C99 6.7.7 (typedef) + 6.3.2.1 (function-to-pointer) + 6.5.2.2 (call).

typedef struct {
    long u;
    long tag;
} V;

typedef V JobFunc(int);

typedef struct {
    JobFunc *job;
} Job;

static V make(int x) {
    V v = {x, x * 2};
    return v;
}

int main(void) {
    Job jj;
    Job *e = &jj;
    e->job = make;

    // Arrow-access call, result assigned to a struct.
    V res;
    res = e->job(7);
    if (res.u != 7 || res.tag != 14) return 1;

    // Dot-access call, struct result used directly.
    jj.job = make;
    if (jj.job(5).u != 5 || jj.job(5).tag != 10) return 2;
    return 0;
}
