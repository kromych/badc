/* C99 6.9.2: a file-scope declaration with no initializer is a
   tentative definition. Repeated tentative definitions of the same
   object, together with at most one initializer, declare a single
   object. A later tentative declaration is redundant and must not
   discard the value an earlier initializer established. */
int x;
int x = 3;
int x;

int a[3] = {1, 2, 3};
int a[3];

int main(void) {
    if (x != 3) {
        return 1;
    }
    if (a[0] + a[1] + a[2] != 6) {
        return 2;
    }
    return 0;
}
