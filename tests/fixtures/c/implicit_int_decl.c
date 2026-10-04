// C89 6.5.2 let a declaration omit the type specifier and take `int`;
// C99 6.7.2p2 requires one. gcc 14 and clang reject the omission by
// default and accept it once -Wimplicit-int is a warning, as the pragma
// below makes it. The identifier in base-type position is the
// declarator when `(` / `;` / `,` / `=` follows it; any other shape
// (`Foo bar;`) keeps the unknown-type-name diagnostic.

#pragma GCC diagnostic warning "-Wimplicit-int"

f(int x) { return x + 1; }

g = 5;

main()
{
    if (f(41) != 42) return 1;
    if (g != 5) return 2;
    return 0;
}
