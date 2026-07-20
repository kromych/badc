/* `weak`, `alias("target")`, and `used` attributes. The alias is a
   second name for the target: calls through either name run the same
   body, and a data alias reads the target's storage. A weak
   definition with no strong override behaves as a plain definition. */
int real_fn(void) { return 41; }
int alias_fn(void) __attribute__((weak, alias("real_fn")));

static int keep_me(void) __attribute__((used));
static int keep_me(void) { return 1; }

int weak_def(void) __attribute__((weak));
int weak_def(void) { return 2; }

int gdata = 7;
extern int gdata_alias __attribute__((alias("gdata")));

int main(void) {
    if (real_fn() != 41) {
        return 1;
    }
    if (alias_fn() != 41) {
        return 2;
    }
    if (weak_def() != 2) {
        return 3;
    }
    if (gdata_alias != 7) {
        return 4;
    }
    gdata = 9;
    if (gdata_alias != 9) {
        return 5;
    }
    return 0;
}
