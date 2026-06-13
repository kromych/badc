// A file-scope `extern` of an incomplete struct type reserves no
// storage (its size is unknown); the defining declaration that follows
// the struct's completion allocates the bytes (C99 6.9.2). A global
// declared between the forward `extern` and the definition must not be
// overlapped by the completed object's storage.

extern struct node nd;   // struct node still incomplete here
int between = 7;
int trailing = 11;

struct node { int a, b; } nd = { 3, 4 };

int main(void) {
    // The completed nd's storage sits past `between` / `trailing`, not
    // on top of them.
    if (nd.a != 3 || nd.b != 4) return 1;
    if (between != 7) return 2;
    if (trailing != 11) return 3;
    if ((char *) &nd == (char *) &between) return 4;
    return 0;
}
