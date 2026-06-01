// C89 6.5.2 / C99 6.7.2p2 (deprecated extension): a declaration
// without a type specifier defaults to `int`. Common in legacy
// K&R-shaped C and in micro-fixtures that omit the return type
// on `main`. badc now honours the implicit-int rule when the
// identifier in base-type position is followed by `(` / `;` /
// `,` / `=`, leaving the typo-on-type-name diagnostic intact for
// the other shapes (`Foo bar;`).

f(int x) { return x + 1; }

g = 5;

main()
{
    if (f(41) != 42) return 1;
    if (g != 5) return 2;
    return 0;
}
