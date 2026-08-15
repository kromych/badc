/* C99 6.5.2.3p4 with 6.7.3p6: a member designated through a pointer
   to a volatile-qualified struct is a volatile lvalue, so the store
   direction is a volatile access exactly like the load direction.
   C99 6.7.3p8: qualifying an array type qualifies its elements, so an
   array member's subscripted accesses are volatile too. Covered
   spellings: plain member assignment, compound assignment, the four
   increment/decrement forms, a nested member chain, the `(*p).m`
   form, an array member element, and a bitfield member. The SSA
   snapshot pins the volatile mark on both directions of each. */

struct inner {
    long x;
};

struct dev {
    long a;
    struct inner in;
    long arr[2];
    unsigned bits : 5;
};

static volatile struct dev d;

static long member_store_load(volatile struct dev *p, long v) {
    p->a = v;
    return p->a;
}

static long member_rmw(volatile struct dev *p) {
    p->a += 3;
    p->a++;
    ++p->a;
    p->a--;
    return p->a;
}

static long nested_and_paren(volatile struct dev *p, long v) {
    p->in.x = v;
    (*p).in.x += v;
    return (*p).in.x;
}

static long array_member(volatile struct dev *p, int i, long v) {
    p->arr[i] = v;
    p->arr[i] += v;
    return p->arr[i];
}

static unsigned bitfield_member(volatile struct dev *p, unsigned v) {
    p->bits = v;
    p->bits += 1;
    return p->bits;
}

int main(void) {
    if (member_store_load(&d, 41) != 41) {
        return 1;
    }
    if (member_rmw(&d) != 45) {
        return 2;
    }
    if (nested_and_paren(&d, 7) != 14) {
        return 3;
    }
    if (array_member(&d, 1, 5) != 10) {
        return 4;
    }
    if (bitfield_member(&d, 9) != 10) {
        return 5;
    }
    return 0;
}
