// C99 6.7.2.3p1: an enum tag declared before its definition names the type
// the definition completes, so a prototype through the tag composes with
// the definition's own type at whatever width the definition gives it, and
// a typedef of the tag reads that width once the definition is in.

enum sreq_ref_trace;
struct subrequest;

struct subrequest *get_subrequest(struct subrequest *subreq, enum sreq_ref_trace what);
typedef enum sreq_ref_trace trace_t;
unsigned trace_size(void);

enum sreq_ref_trace { trace_get_a, trace_get_b, trace_get_c } __attribute__((__mode__(__byte__)));
struct subrequest { int ref; };

struct subrequest *get_subrequest(struct subrequest *subreq, enum sreq_ref_trace what)
{
    subreq->ref += (int)what + 1;
    return subreq;
}

unsigned trace_size(void) { return sizeof(trace_t); }

// C99 6.7.2.2p4: an enum is compatible with the integer type chosen for it.
enum level { low = 2, high = 7 };
int scale(enum level);
int scale(unsigned int l) { return (int)l * 3; }

int main(void)
{
    struct subrequest s = { 0 };
    trace_t t = trace_get_c;
    get_subrequest(&s, trace_get_b);
    get_subrequest(&s, t);
    if (s.ref != 5) return 1;
    if (sizeof(enum sreq_ref_trace) != 1 || trace_size() != 1 || sizeof t != 1) return 2;
    if (scale(high) != 21) return 3;
    return 0;
}
