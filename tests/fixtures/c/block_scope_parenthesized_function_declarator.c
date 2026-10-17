// A parenthesized declarator declares what the bare one does (C99 6.7.5p6):
// at block scope `ll (f)(ll, ll);` declares the function `f`, as at file
// scope, nested parentheses and a pointer result included, and attributes
// inside the parentheses name the calling convention of the function, as
// they do for a pointer declarator. A parenthesized object declarator
// still declares an object.
typedef long long ll;
#if defined(__x86_64__)
#define MSF __attribute__((ms_abi))
#else
#define MSF
#endif

static ll cell = 7;

ll calls(ll a, ll b) {
    ll (sub)(ll, ll);
    ll ((twice))(ll);
    ll *(where)(void);
    ll (MSF msf)(ll, ll);
    ll (x) = a;
    ll (arr)[2] = {b, 1};
    ll (*p)(ll, ll) = sub;
    return sub(x, arr[0]) * 1000 + twice(arr[1]) * 100 + *where() * 10 + p(9, 8) +
           msf(40, 2) * 10000;
}

ll sub(ll a, ll b) { return a - b; }
ll twice(ll a) { return 2 * a; }
ll *where(void) { return &cell; }
MSF ll msf(ll a, ll b) { return a / b; }

int main(void) {
    return calls(5, 3) == 20 * 10000 + 2 * 1000 + 2 * 100 + 7 * 10 + 1 ? 0 : 1;
}
