// Nested counted loops with continue paths that share the inner
// step block. The layout pass keeps each loop's blocks contiguous,
// rotates both loops to bottom-test form, and places the shared
// step block directly before the rotated inner header so the back
// edge falls through.
int main(void) {
    int total = 0;
    int i, j;
    for (i = 0; i < 6; i++) {
        for (j = 0; j < i; j++) {
            if ((i + j) % 3 == 0)
                continue;
            if (j == 4)
                continue;
            total += j;
        }
        total += i;
    }
    return total;
}
