// A C library function or object the program declares itself, without the
// bundled header's binding, resolves to the library's definition, as a
// value and as an address. Exits 0 when `environ` holds an entry and the
// address taken of `strlen` computes a length.

__SIZE_TYPE__ strlen(const char *);

#ifndef _WIN32
extern char **environ;
#endif

int main(void) {
#ifndef _WIN32
    if (!environ || !environ[0])
        return 1;
#endif
    __SIZE_TYPE__ (*volatile len)(const char *) = strlen;
    return len("abc") == 3 ? 0 : 2;
}
