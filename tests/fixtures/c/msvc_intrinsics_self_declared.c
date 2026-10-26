// MSVC's compiler intrinsics with no library function, declared by the
// unit itself and enabled with `#pragma intrinsic`, as MSVC documents:
// the barriers emit no call and no instruction, `_ReturnAddress` is the
// calling function's return address and `_AddressOfReturnAddress` the
// slot holding it. Off the PE targets the unit checks nothing.

#ifdef _WIN32
void _ReadWriteBarrier(void);
#pragma intrinsic(_ReadWriteBarrier)
void _ReadBarrier(void);
void _WriteBarrier(void);
#pragma intrinsic(_ReadBarrier, _WriteBarrier)
void *_ReturnAddress(void);
#pragma intrinsic(_ReturnAddress)
void *_AddressOfReturnAddress(void);
#pragma intrinsic(_AddressOfReturnAddress)

static int x;

__declspec(noinline) static void *where(void) { return _ReturnAddress(); }

__declspec(noinline) static int slot_holds_it(void) {
    return *(void **)_AddressOfReturnAddress() == _ReturnAddress();
}

int main(void) {
    x = 1;
    _ReadWriteBarrier();
    x += 1;
    _ReadBarrier();
    _WriteBarrier();
    void *r = where();
    return (r != 0 ? x - 2 : 10) + (slot_holds_it() ? 0 : 20);
}
#else
int main(void) { return 0; }
#endif
