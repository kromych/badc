/* A deferred-size array whose initializer resolves to zero elements
 * (`T a[] = { }`) keeps its array-ness in nested blocks and statement
 * expressions: it decays, subscripts type-check, and sizeof is 0. */
int main(void) {
    int r1;
    r1 = ({
        unsigned long long a[] = {};
        (int)sizeof(a);
    });
    if (r1 != 0)
        return 1;

    int r2;
    r2 = ({
        unsigned long long a[] = {};
        (int)sizeof((a)[0]);
    });
    if (r2 != 8)
        return 2;

    {
        unsigned long long b[] = {};
        if (sizeof(b) != 0)
            return 3;
        if (sizeof((b)[0]) != 8)
            return 4;
        unsigned long long *p = b;
        if (p != b)
            return 5;
    }
    return 0;
}
