// A block-scope `extern` declaration of an object has external linkage
// and refers to the file-scope object of the same name (C99 6.2.2p4);
// it allocates no local storage and does not shadow the outer binding,
// so its address is the global's, not a fresh local.

struct point { int x, y; };
struct point pt = { 3, 4 };
int counter = 5;
int row[3] = { 10, 20, 30 };

int main(void) {
    extern struct point pt;   // same object as the file-scope pt
    extern int counter;       // same object as the file-scope counter
    extern int row[];         // same object as the file-scope row

    if (&pt == 0) return 1;
    if (pt.x != 3 || pt.y != 4) return 2;
    if (counter != 5) return 3;
    if (row[0] + row[1] + row[2] != 60) return 4;

    counter = 9;
    return counter == 9 ? 0 : 5;
}
