// C99 6.7.8p22: a deferred-size array's size is one greater than the largest
// index initialized, whether reached positionally or by a `[N]` designator.
// A real-world shape uses enum-indexed designators with gaps. Sizes,
// designated values, positional-after-designator, backward designators, and
// zeroed gaps match GCC/clang. Returns 0 on success.

enum { A = 0, B = 5, C = 28, D = 2 };
struct P {
    int x;
    int y;
};

// Sparse designators; the largest index (28) sets the size to 29.
struct P sparse[] = {[A] = {1, 2}, [B] = {3, 4}, [C] = {5, 6}, [D] = {7, 8}};

// Positional then a designator jump then positional again then a backward
// designator: elements land at 0, 3, 4, 1 -> size 5.
struct P mix[] = {{10, 11}, [3] = {30, 31}, {40, 41}, [1] = {100, 101}};

// Scalar deferred array with designators and gaps.
char tags[] = {[2] = 'c', [0] = 'a', [4] = 'e'};

int main(void) {
    if (sizeof(sparse) / sizeof(sparse[0]) != 29) {
        return 1;
    }
    if (sparse[0].x != 1 || sparse[5].x != 3 || sparse[28].x != 5 || sparse[28].y != 6 ||
        sparse[2].x != 7) {
        return 2;
    }
    if (sparse[3].x != 0 || sparse[27].y != 0) { // unwritten gaps are zero
        return 3;
    }
    if (sizeof(mix) / sizeof(mix[0]) != 5) {
        return 4;
    }
    if (mix[0].x != 10 || mix[1].x != 100 || mix[3].x != 30 || mix[4].x != 40 || mix[2].x != 0) {
        return 5;
    }
    if (sizeof(tags) != 5 || tags[0] != 'a' || tags[2] != 'c' || tags[4] != 'e' || tags[1] != 0) {
        return 6;
    }
    return 0;
}
