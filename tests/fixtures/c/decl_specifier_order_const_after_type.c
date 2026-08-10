// C99 6.7.1p1: the specifiers of a declaration may appear in any order,
// so `const` written after the type specifier qualifies the object
// exactly as one written before it. A const-qualified integer object
// with static storage folds into a later constant expression, so every
// array dimension below is an integer constant expression in both
// spellings and at every scope.

static int const FILE_TRAIL = 4;
static const int FILE_LEAD = 4;
static char file_trail_buf[FILE_TRAIL * 2 + 1];
static char file_lead_buf[FILE_LEAD * 2 + 1];

static int body_scope(void) {
    static int const TRAIL = 4;
    static const int LEAD = 4;
    static char trail_buf[TRAIL * 2 + 1];
    static char lead_buf[LEAD * 2 + 1];
    trail_buf[0] = 1;
    lead_buf[0] = 1;
    if (sizeof lead_buf != 9) return 0;
    return (int)sizeof trail_buf;
}

static int nested_scope(void) {
    {
        static int const TRAIL = 3;
        static const int LEAD = 3;
        static char trail_buf[TRAIL * 2 + 1];
        static char lead_buf[LEAD * 2 + 1];
        trail_buf[0] = 1;
        lead_buf[0] = 1;
        if (sizeof lead_buf != 7) return 0;
        return (int)sizeof trail_buf;
    }
}

// `unsigned` and `long long` written around the qualifier reach the same
// base type; the trailing `const` still qualifies the object.
static int mixed_spelling(void) {
    static unsigned const int U = 5;
    static char buf[U + 1];
    buf[0] = 1;
    return (int)sizeof buf;
}

int main(void) {
    if (sizeof file_trail_buf != 9) return 1;
    if (sizeof file_lead_buf != 9) return 2;
    if (body_scope() != 9) return 3;
    if (nested_scope() != 7) return 4;
    if (mixed_spelling() != 6) return 5;
    return 0;
}
