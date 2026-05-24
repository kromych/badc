/* Exercises switch-case fall-through with `break;`-terminated case
   bodies followed by other cases plus the default arm. C99 6.8.4.2
   makes each case marker a re-entry point regardless of how the
   preceding body ended; this fixture pins that contract end-to-end
   so a walker change that drops a case (e.g. via the dead-code
   skip in the BlockItem loop) surfaces here too. */
int f1(void) { return 100; }
int f2(void) { return 200; }
int f3(void) { return 300; }
int f4(void) { return 400; }

int driver(int op) {
    int x = 0;
    switch (op) {
        case 0: x = f1(); break;
        case 1: x = f2(); break;
        case 2: x = f3(); break;
        default: x = f4();
    }
    return x;
}

int main(void) {
    return driver(2);
}
