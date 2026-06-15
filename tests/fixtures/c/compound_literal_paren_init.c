// A compound literal (C99 6.5.2.5) is a primary expression and may be
// wrapped in grouping parentheses (C99 6.5.1), as macro bodies commonly
// do: `#define NO_LABEL ((const Label){-1})`. Such a parenthesized
// compound literal must be accepted as an element of an aggregate
// initializer, at file scope and block scope, with any nesting depth.

typedef struct { int id; } Label;
typedef struct { void *a; void *b; void *c; Label lbl; } State;

#define NO_LABEL ((const Label){-1})

static State g = { 0, 0, 0, NO_LABEL };

int main(void) {
    State s = { 0, 0, 0, ((Label){7}) };
    State t = { 0, 0, 0, (((Label){9})) };
    if (g.lbl.id != -1) return 1;
    if (s.lbl.id != 7) return 2;
    if (t.lbl.id != 9) return 3;
    // The unparenthesized form must keep working too.
    State u = { 0, 0, 0, (Label){3} };
    if (u.lbl.id != 3) return 4;
    return 0;
}
