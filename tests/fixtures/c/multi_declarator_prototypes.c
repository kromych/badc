/* C99 6.7: one declaration may introduce several declarators, mixing
   function prototypes with object declarations, e.g.
   `int f(int a), g(int a), n;`. A prototype here is followed by a comma
   and further declarators, not a function body. */
int f(int a), g(int a), n;

int f(int a) { return a; }
int g(int a) { return a * 2; }

int main(void) {
    n = 10;
    if (f(3) != 3) {
        return 1;
    }
    if (g(3) != 6) {
        return 2;
    }
    if (n != 10) {
        return 3;
    }
    return 0;
}
