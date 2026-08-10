/* C99 6.2.1: a name declared in a nested block shadows an outer binding only
   for that block; at block exit the outer binding is restored in full,
   including its array / VLA shape. A nested-block declarator retypes the
   reused symbol slot, so restoring only the class/type/value left the outer
   variable stuck with the inner declarator's array-ness -- a later use then
   miscompiled (an outer scalar read as an array, or the reverse). */

int main(void) {
    int msg = 42;
    {
        char msg[4];
        msg[0] = 9;
        msg[3] = 1;
    }
    if (msg != 42) /* outer scalar, not the inner char[4] */
        return 1;

    int a[3];
    a[0] = 5;
    a[1] = 6;
    {
        int a = 100;
        if (a != 100)
            return 2;
    }
    if (a[0] != 5 || a[1] != 6) /* outer array, not the inner scalar */
        return 3;

    int x = 7;
    {
        long x[2];
        x[0] = 1;
        {
            char x;
            x = 3;
            if (x != 3)
                return 4;
        }
        if (x[0] != 1) /* back to the level-1 array */
            return 5;
    }
    if (x != 7) /* back to the outer scalar */
        return 6;

    int i = 88;
    for (long i = 0; i < 3; i++) {
    }
    if (i != 88) /* the for-init binding's scope ended with the loop */
        return 7;

    return 0;
}
