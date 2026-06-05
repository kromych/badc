/* C99 6.2.1p4: a name declared with linkage at file scope is
   shadowed inside an inner block by another declaration of the
   same name with no linkage. The c5 parser's hash-keyed symbol
   table has one entry per name, so the inner declaration mutates
   the entry's class / val while a `block_symbols` shadow saves the
   outer values for restoration at block exit.

   The block_symbols mechanism restores class / type / val but NOT
   linkage / is_extern_decl / defined_here. Once the block exits,
   the symbol looks like an extern function (the outer prototype)
   even though emit_data_imm at the inner scope wrote the
   static-local's data offset into the operand.

   link_unit's glo_imm_refs filter must NOT classify such a
   restored-to-outer entry as a cross-TU extern reference, or the
   resulting ImmDataAddr reloc points the operand at the outer
   function instead of the static-local array.

   This fixture returns 42 only when the static-local `expect[]`
   read in the body reaches the local data segment rather than the
   prototyped `expect` function. */

extern int expect(const char *msg);

static int sum_first_two(const unsigned char *p) {
    return (int)p[0] + (int)p[1];
}

int driver(int type) {
    int r = 0;
    switch (type) {
        case 1: {
            static const unsigned char expect[] = { 17, 25, 99, 99 };
            r = sum_first_two(expect);
            break;
        }
        case 2:
            r = -1;
            break;
    }
    return r;
}

int main(void) {
    return driver(1);
}
