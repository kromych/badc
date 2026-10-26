// POSIX.1-2008 <setjmp.h>: _setjmp / _longjmp and sigsetjmp / siglongjmp
// return at the call with the value the jump passes, a volatile automatic
// keeps the value it had at the jump, and sigsetjmp with a nonzero
// savemask restores the signal mask it saved.
#include <setjmp.h>
#include <signal.h>

static jmp_buf jb;
static sigjmp_buf sjb;

static void jump_plain(void) { _longjmp(jb, 3); }
static void jump_sig(void) { siglongjmp(sjb, 5); }

int main(void) {
    volatile int n = 0;
    sigset_t blk, cur;
    int r = _setjmp(jb);
    if (r == 0) {
        n = 1;
        jump_plain();
        return 1;
    }
    if (r != 3 || n != 1) return 2;
    sigemptyset(&blk);
    sigaddset(&blk, SIGUSR1);
    r = sigsetjmp(sjb, 1);
    if (r == 0) {
        n = 2;
        sigprocmask(SIG_BLOCK, &blk, 0);
        jump_sig();
        return 3;
    }
    if (r != 5 || n != 2) return 4;
    sigprocmask(SIG_SETMASK, 0, &cur);
    if (sigismember(&cur, SIGUSR1)) return 5;
    return 0;
}
