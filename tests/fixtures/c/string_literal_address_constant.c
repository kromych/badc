// A string literal is an unnamed static array of the element type its
// prefix gives (C99 6.4.5p5, C11 6.4.5p6). In a constant expression it
// decays to an address constant that keeps its relocation through pointer
// arithmetic, at file and block scope; a constant subscript reads its
// element in the element's type; at run time a wide literal indexes by its
// element.

typedef __WCHAR_TYPE__ wchar_t;
typedef __CHAR16_TYPE__ char16_t;
typedef __CHAR32_TYPE__ char32_t;

const char *plus = "hello" + 1;
const char *plus_rev = 2 + "hello";
const char *cast_plus = (const char *)"hello" + 3;
const char *minus = "hello" - 0;
const char *index_addr = &"hello"[4];
const char *swapped_addr = &1["hello"];
struct pair { int n; const char *s; } pair = {3, "hello" + 2};
const char *list[] = {"ab" + 1, "cd", 1 ? "ef" + 1 : 0};
const wchar_t *wide_plus = L"ab" + 1;
const wchar_t *wide_index_addr = &L"abc"[2];
const char16_t *u16_plus = u"ab" + 1;
const char32_t *u32_plus = U"ab" + 1;
const unsigned char *uchar_plus = (const unsigned char *)"\x80\x81" + 1;

int plain_elem = "\xff"[0];
int cast_elem = ((const char *)"abc")[1];
int deref_elem = *"abc";
int deref_plus = *("abc" + 1);
int swapped_elem = 1["abc"];
int plus_elem = ("abc" + 1)[1];
int wide_elem = L"ab"[1];
int u16_elem = u"\x8000"[0];
int u32_elem = U"\xffffffff"[0];

_Static_assert(__builtin_constant_p("abc"), "a string literal");
_Static_assert(__builtin_constant_p(("abc")), "a parenthesized string literal");
_Static_assert(__builtin_constant_p((__INTPTR_TYPE__)"abc"), "a cast string literal");
_Static_assert(__builtin_constant_p(&"abc"[0]), "the literal's first element");
_Static_assert(!__builtin_constant_p("abc" + 1), "an address inside the literal");
_Static_assert(!__builtin_constant_p(&"abc"[1]), "an element address inside the literal");

static const char *block_scope(int k)
{
    static const char *addr = &"xyz"[1];
    static const char *sum = "xyz" + 2;
    static const wchar_t *wide = L"xyz" + 1;
    if (addr[0] != 'y' || sum[0] != 'z' || wide[0] != L'y')
        return 0;
    return k ? sum : addr;
}

int main(void)
{
    volatile int one = 1, zero = 0;
    if (plus[0] != 'e' || plus_rev[0] != 'l' || cast_plus[0] != 'l') return 1;
    if (minus[0] != 'h' || index_addr[0] != 'o' || swapped_addr[0] != 'e') return 2;
    if (pair.n != 3 || pair.s[0] != 'l') return 3;
    if (list[0][0] != 'b' || list[1][1] != 'd' || list[2][0] != 'f') return 4;
    if (wide_plus[0] != L'b' || wide_index_addr[0] != L'c') return 5;
    if (u16_plus[0] != u'b' || u32_plus[0] != U'b' || uchar_plus[0] != 0x81) return 6;
    if (plain_elem != (char)0xff || cast_elem != 'b' || deref_elem != 'a') return 7;
    if (deref_plus != 'b' || swapped_elem != 'b' || plus_elem != 'c') return 8;
    if (wide_elem != L'b' || u16_elem != 0x8000 || u32_elem != -1) return 9;
    const char *p = block_scope(0), *q = block_scope(1);
    if (!p || p[0] != 'y' || q[0] != 'z') return 10;
    if (L"ab"[one] != L'b' || *(L"xyz" + 2 * one) != L'z') return 11;
    if (u"\x8000"[zero] != 0x8000 || "\xff"[zero] != (char)0xff) return 12;
    if (sizeof(L"ab") != 3 * sizeof(wchar_t) || sizeof(u"ab"[0]) != 2) return 13;
    return 0;
}
