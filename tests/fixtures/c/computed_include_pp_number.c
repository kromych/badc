/* Regression: a computed include (C99 6.10.2p4) whose file name
 * starts with a digit. The name substitutes as the pp-tokens
 * `1x` `.` `h`, and both the header name and the stringized
 * spelling concatenate the spellings with no separator: `1x.h`
 * written adjacently is a single pp-number (C99 6.4.8), and `#`
 * inserts a space only where the argument had white space
 * (C99 6.10.3.2). Checked against gcc.
 */
#include <string.h>

#define STR_(x) #x
#define STR(x) STR_(x)

/* Angle form assembled from pp-tokens, resolved as <stdint.h>. */
#define ANGLE_(n) <n.h>
#define ANGLE(n) ANGLE_(n)
#include ANGLE(stdint)

/* Quoted form via stringize, resolved against this file's directory. */
#define NAME_D 1x
#define DIR ev
#define QUOTED_(d, n) STR(d/n.h)
#define QUOTED(d, n) QUOTED_(d, n)
#include QUOTED(DIR, NAME_D)

#define ND 1x

int main(void) {
    int32_t from_angle = 1;                       /* stdint via ANGLE */
    if (marker_1x() != 42) return 1;              /* ev/1x.h via QUOTED */
    if (strcmp(STR_(1x.h), "1x.h")) return 2;     /* one pp-number */
    if (strcmp(STR(ND.h), "1x.h")) return 3;      /* substituted adjacency */
    if (strcmp(STR_(1x .h), "1x .h")) return 4;   /* real white space */
    if (strcmp(STR(tr/ND.h), "tr/1x.h")) return 5;
    return from_angle ? 0 : 6;
}
