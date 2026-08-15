// Address-constant initializers on `_Thread_local` objects (C99
// 6.7.8p4: thread storage duration takes the same initializer forms
// as static). The relocation applies to the initialization template
// the runtime copies per thread: ELF `.tdata` via R_*_RELATIVE at the
// template's own address, Mach-O `__DATA,__thread_data` via a rebase
// opcode, PE via an IMAGE_REL_BASED_DIR64 entry in the `.data` TLS
// blob. Every loader applies image relocations before any thread's
// block exists, so the per-thread copies inherit the relocated value.
//
// Each form below is a distinct address constant and takes a distinct
// path through the initializer parser.

static int fn(void) { return 4; }
static int arr[4] = { 1, 2, 3, 4 };
struct pair { int a; int b; };
static struct pair pr = { 5, 6 };
static int g = 7;
int visible_g = 8;

__thread int (*fp)(void)     = fn;                  // function designator
__thread const char *msg     = "hi";                // string literal
__thread int *decay          = arr;                 // array decay
__thread int *elem           = &arr[1];             // array element
__thread int *plus           = arr + 2;             // address plus offset
__thread int *memb           = &pr.b;               // struct sub-object
__thread int *whole          = &g;                  // file-scope static
__thread int *ext            = &visible_g;          // external linkage
__thread unsigned long uaddr = (unsigned long)&g;   // pointer-width int slot
__thread int *none           = 0;                   // null, no relocation
__thread long plain          = 42;                  // integer, no relocation

int main() {
    if (fp() != 4) return 1;
    if (msg[0] != 'h' || msg[1] != 'i' || msg[2] != 0) return 2;
    if (decay != arr) return 3;
    if (elem != &arr[1] || *elem != 2) return 4;
    if (plus != &arr[2] || *plus != 3) return 5;
    if (memb != &pr.b || *memb != 6) return 6;
    if (whole != &g || *whole != 7) return 7;
    if (ext != &visible_g || *ext != 8) return 8;
    if (uaddr != (unsigned long)&g) return 9;
    if (none != 0) return 10;
    if (plain != 42) return 11;
    // The template is writable per thread; a store must not disturb
    // the object it pointed at.
    whole = &visible_g;
    if (*whole != 8 || g != 7) return 12;
    return 0;
}
