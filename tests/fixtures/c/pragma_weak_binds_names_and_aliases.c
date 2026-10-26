/* `#pragma weak name` binds a definition weak and `#pragma weak name =
 * target` declares a weak alias, before or after the declaration and
 * through `_Pragma`, as the `weak` and `alias` attributes do; references
 * made before the pragma reach the alias's target. Returns 0. */
#pragma weak before
int before = 1;
int after = 2;
_Pragma("weak after")
int impl(void) { return 3; }
#pragma weak api = impl
int api(void);
int obj = 5;
extern int late;
static int read_late(void) { return late; }
static int *addr_late(void) { return &late; }
#pragma weak early = obj
extern int early;
#pragma weak late = obj

int main(void) {
    if (before + after + api() != 6) {
        return 1;
    }
    return early == 5 && &early == &obj && read_late() == 5 && addr_late() == &obj ? 0 : 2;
}
