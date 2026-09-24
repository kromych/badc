// The __int128 division helpers of libgcc and compiler-rt (`__udivti3` and
// family), which gcc and clang call where badc divides inline. Offered on
// demand like compiler_rt.c, and apart from it, so an image that pulls that
// object for another helper does not carry these.

// TODO: Windows, where badc returns a 16-byte integer through a hidden
// pointer, once that is checked against gcc's and clang's calls.
#if defined(__SIZEOF_INT128__) && !defined(_WIN32)

typedef unsigned __int128 __bcrt_u128;
typedef __int128 __bcrt_s128;

__bcrt_u128 __udivti3(__bcrt_u128 a, __bcrt_u128 b) { return a / b; }
__bcrt_u128 __umodti3(__bcrt_u128 a, __bcrt_u128 b) { return a % b; }
__bcrt_s128 __divti3(__bcrt_s128 a, __bcrt_s128 b) { return a / b; }
__bcrt_s128 __modti3(__bcrt_s128 a, __bcrt_s128 b) { return a % b; }

__bcrt_u128 __udivmodti4(__bcrt_u128 a, __bcrt_u128 b, __bcrt_u128 *rem) {
    if (rem)
        *rem = a % b;
    return a / b;
}

__bcrt_s128 __divmodti4(__bcrt_s128 a, __bcrt_s128 b, __bcrt_s128 *rem) {
    *rem = a % b;
    return a / b;
}

#endif // __SIZEOF_INT128__ && !_WIN32
