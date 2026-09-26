// C11 6.7.9: an object with thread storage duration takes the initializers
// of an object with static storage duration -- arrays, structs, a deferred
// size, string literals, and addresses of data, strings and functions --
// at file and at block scope. Every thread starts from that image: a second
// thread reads the initial values, and its writes stay out of the main
// thread's copies. Returns 0, distinct non-zero per failure.

#ifdef _WIN32
#include <windows.h>
#else
#include <pthread.h>
#endif

static int g[3] = {1, 2, 3};
static int seven(void) { return 7; }

static _Thread_local int tl[4] = {1, 2, 3, 4};
_Thread_local int deferred[] = {5, 6, 7};
static _Thread_local struct S {
    int a, b;
    const char *s;
    int *p;
    int (*f)(void);
} ts = {1, 2, "ts", &g[2], seven};
_Thread_local char tname[8] = "name";
_Thread_local struct P { char tag[4]; double d; } tp[] = {{"ab", 1.5}, {"cd", 2.5}};

static int counter(void) {
    static _Thread_local int calls[2] = {10, 20};
    static _Thread_local const char *names[] = {"x", "yz"};
    return ++calls[0] + calls[1] + names[1][1];
}

static int *first(void) {
    static _Thread_local int *p = &g[0];
    static _Thread_local int n = 4;
    return n++ == 4 ? p : 0;
}

// The initial image as this thread sees it; each check then writes its
// thread's copy.
static int check(void) {
    if (tl[0] != 1 || tl[3] != 4) return 1;
    if (sizeof deferred != 3 * sizeof(int) || deferred[2] != 7) return 2;
    if (ts.a != 1 || ts.b != 2 || ts.s[1] != 's' || *ts.p != 3 || ts.f() != 7) return 3;
    if (tname[3] != 'e' || tname[4] != 0) return 4;
    if (sizeof tp != 2 * sizeof(struct P) || tp[1].d != 2.5 || tp[1].tag[1] != 'd') return 5;
    if (counter() != 31 + 'z' || counter() != 32 + 'z') return 6;
    if (first() != &g[0] || first() != 0) return 7;
    tl[0] = 100;
    ts.a = 100;
    tp[0].d = 100.0;
    return 0;
}

#ifdef _WIN32
static DWORD WINAPI thread_main(LPVOID arg) {
    (void)arg;
    return (DWORD)check();
}
#else
static void *thread_main(void *arg) {
    (void)arg;
    return (void *)(long)check();
}
#endif

int main(void) {
    int r = check();
    if (r) return r;
#ifdef _WIN32
    DWORD code = 0;
    HANDLE h = CreateThread(0, 0, thread_main, 0, 0, 0);
    if (!h) return 20;
    WaitForSingleObject(h, INFINITE);
    GetExitCodeThread(h, &code);
    CloseHandle(h);
    r = (int)code;
#else
    pthread_t t;
    void *ret;
    if (pthread_create(&t, 0, thread_main, 0) != 0) return 20;
    pthread_join(t, &ret);
    r = (int)(long)ret;
#endif
    if (r) return 10 + r;
    if (tl[0] != 100 || ts.a != 100 || tp[0].d != 100.0) return 21;
    return 0;
}
