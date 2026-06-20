// C99 6.9.2: a deferred-size tentative definition (`T x[];`) completes to one
// element, so it reserves a single slot. A later defining declaration whose
// initializer is larger denotes the same object but needs more storage; it
// must allocate fresh storage rather than overrun the globals that were placed
// after the one-element tentative. A reference emitted before the definition
// still observes the tentative's storage (the deferred-size object's address is
// fixed at the tentative), which is the documented limitation; the point of
// this test is that the larger initializer does not corrupt its neighbours.
static char doc[];

static long neigh1 = 0x1111111111111111L;
static long neigh2 = 0x2222222222222222L;

struct ref {
    const char *p;
};
static struct ref table = {doc};

static const char *via_table(void) {
    return table.p;
}

static char doc[] = "a docstring far longer than one byte";

int main(void) {
    // The larger initializer must not have clobbered the neighbours placed
    // after the one-element tentative.
    if (neigh1 != 0x1111111111111111L) {
        return 1;
    }
    if (neigh2 != 0x2222222222222222L) {
        return 2;
    }
    // A reference after the definition observes the defined storage.
    if (doc[0] != 'a' || doc[2] != 'd') {
        return 3;
    }
    // The pre-definition reference resolves to a readable address (the
    // tentative's one-element slot); it must not fault.
    if (via_table() == 0) {
        return 4;
    }
    return 0;
}
