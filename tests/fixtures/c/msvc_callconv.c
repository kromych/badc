// MSVC calling-convention keywords decorate declarators on Windows
// headers (Win32 / OpenGL: `WINAPI`, `APIENTRY`, and bare `__stdcall`).
// Each badc target has a single calling convention, so they are no-op
// qualifiers: they must parse in the declaration position and inside a
// function-pointer declarator's parentheses, and the code must run.

static int __stdcall add_std(int a, int b) { return a + b; }
static int __cdecl add_cdecl(int a, int b) { return a + b; }
static int __fastcall add_fast(int a, int b) { return a + b; }

typedef int(__stdcall *binop)(int, int);
typedef void(__cdecl *sink)(int);

static int total;
static void __cdecl record(int x) { total += x; }

int main(void) {
    binop f = add_std;
    sink s = record;
    int r = f(20, 22) + add_cdecl(1, 1) + add_fast(3, 4);
    s(r);
    return (r == 51 && total == 51) ? 0 : 1;
}
