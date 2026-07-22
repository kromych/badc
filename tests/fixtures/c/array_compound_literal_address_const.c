/* C99 6.5.2.5 + 6.6: the address of a member reached through an array-typed
   compound literal `&(T[]){ ... }[i].member.member` is an address constant.
   The literal is an anonymous static array; a following `[i]` and `.member`
   chain designates the object whose address is stored. Exercised as an array
   of pointers, the shape a sysfs attribute table uses. */

struct inner {
    int tag;
    int val;
};

struct outer {
    struct inner a;
    int id;
};

static int *table[] = {
    (&((struct outer[]){{.a = {.tag = 1, .val = 10}, .id = 100}})[0].a.val),
    (&((struct outer[]){{.a = {.tag = 2, .val = 20}, .id = 200}})[0].a.tag),
    (&((struct outer[]){{.a = {.tag = 3, .val = 30}, .id = 300}})[0].id),
};

int main(void) {
    if (*table[0] != 10)
        return 1;
    if (*table[1] != 2)
        return 2;
    if (*table[2] != 300)
        return 3;
    return 0;
}
