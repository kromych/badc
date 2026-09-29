/* A const thread-local's value, element or member folds in a static
   initializer from the thread-local template, as gcc folds it, at file and
   block scope. */

int pad[4] = {1, 2, 3, 4};
struct S {
    int a;
    int b : 5;
};
_Thread_local const int k = 5;
_Thread_local const int k2[2] = {6, 7};
_Thread_local const struct S ks = {8, 9};
int y = k, y2 = k2[1], y3 = ks.a, y4 = ks.b;

static int block(void) {
    static _Thread_local const int kk[2] = {3, 4};
    static int z = kk[1];
    return z;
}

int main(void) {
    if (y != 5) return 1;
    if (y2 != 7) return 2;
    if (y3 != 8) return 3;
    if (y4 != 9) return 4;
    if (block() != 4) return 5;
    return 0;
}
