// C99 6.7.2.2 / 6.7.2.1: an `enum X` is a usable type-spec
// in any declarator context, including a struct field. c5
// already collapses every enum to plain `int`, but
// `parse_aggregate_body` used to skip the Enum branch and
// fell through to "type expected in struct field" the moment
// a struct member referenced an enumerated type. Surfaced
// compiling stb_vorbis 1.22 (`enum STBVorbisError error;` in
// the per-decoder state struct).
#include <stdio.h>

enum Phase {
    Idle = 0,
    Active = 1,
    Done = 2,
};

struct State {
    int  counter;
    enum Phase phase;
};

int main(void) {
    struct State s;
    s.counter = 5;
    s.phase = Active;
    if (s.counter != 5) return 1;
    if (s.phase != 1) return 1;

    // `enum X` body inside a struct decl: `enum { A, B } x;`
    // is also legal C99 -- the unnamed enum's constants
    // promote into the surrounding scope.
    struct Inline {
        enum { Red, Green, Blue } colour;
        int rank;
    } it;
    it.colour = Green;
    it.rank = 7;
    if (it.colour != 1) return 1;
    if (it.rank != 7) return 1;
    return 13;
}
