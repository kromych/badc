/* A pointer struct field initialized with the address of an array-of-struct
   compound literal in a static initializer -- QEMU's ubiquitous
   VMStateDescription.fields / TypeInfo.interfaces shape. The `(const T[])`
   cast names the literal's type, not the pointer field's, so it must reach
   the leaf (which stores the anonymous array's address); it must not be
   stripped as an in-place member initializer. Includes an empty `{ }`
   trailing element (all-zero), which the deferred-size element count must
   still tally. */

struct Field { const char *name; int size; };
struct Desc  { int version; const struct Field *fields; };

static const struct Desc d = {
    .version = 3,
    .fields = (const struct Field[]){
        { "head", 4 },
        { "tail", 8 },
        { },            /* end-of-list sentinel: all zero */
    },
};

/* nested-designator-chain variant landing on a pointer final member */
struct Outer { struct Desc inner; };
static const struct Outer o = {
    .inner.fields = (const struct Field[]){ { "x", 1 } },
};

int main(void) {
    if (d.version != 3) return 1;
    if (d.fields[0].name[0] != 'h' || d.fields[0].size != 4) return 2;
    if (d.fields[1].size != 8) return 3;
    if (d.fields[2].name != 0 || d.fields[2].size != 0) return 4;   /* the `{ }` */
    if (o.inner.fields[0].name[0] != 'x' || o.inner.fields[0].size != 1) return 5;
    return 0;
}
