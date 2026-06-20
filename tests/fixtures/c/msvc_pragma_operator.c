// MSVC `__pragma(tokens)` is the analog of C99 6.10.9 `_Pragma("tokens")`:
// a preprocessing operator whose operand is raw tokens rather than a string
// literal. It carries the same directives as `#pragma` and contributes no
// tokens to the translation unit, so it may appear anywhere, including between
// struct members. `warning(...)` is accepted and ignored; `pack(...)` adjusts
// the field alignment of the following declarations.
__pragma(warning(push))
__pragma(warning(disable : 4201))

__pragma(pack(push, 1))
struct Packed {
    char c;
    int i;
};
__pragma(pack(pop))

struct Normal {
    char c;
    int i;
};

__pragma(warning(pop))

_Pragma("pack(push, 1)")
struct PackedViaC99 {
    char c;
    int i;
};
_Pragma("pack(pop)")

int main(void) {
    if (sizeof(struct Packed) != 5) {
        return 1;
    }
    if (sizeof(struct Normal) != 8) {
        return 2;
    }
    if (sizeof(struct PackedViaC99) != 5) {
        return 3;
    }
    return 0;
}
