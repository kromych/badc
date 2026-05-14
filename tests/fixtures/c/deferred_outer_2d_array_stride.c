// Deferred-outer multi-dim array shapes (C99 6.7.5.2: an
// outer `[]` is allowed when an initializer supplies the
// count, and the trailing `[N]` dimensions stay required).
// For `T arr[][N]` the indexer must stride `arr[i]` by
// `N * sizeof(T)`; a regression that left `array_dims` empty
// collapsed the stride to `sizeof(T)` and made `arr[i][j]`
// walk into the previous row's tail bytes.
//
// The fix records `array_dims = [0, N, ...]` at declaration
// time (zero placeholder for the deferred outer dim) and
// patches the placeholder with the resolved count once the
// initializer has been parsed.

#include <stdio.h>

static char *table[][2] = {
  {"AA", "BB"},
  {"CC", 0},
  {0, "DD"},
};

static int counts[][3] = {
  {1, 2, 3},
  {4, 5, 6},
  {7, 8, 9},
  {10, 11, 12},
};

int main() {
  if ((int)sizeof(table) != 48) return 1;        // 3 rows * 2 ptrs * 8 bytes
  if ((int)sizeof(table[0]) != 16) return 2;      // 2 ptrs * 8 bytes
  if ((int)sizeof(*table) != 16) return 3;        // same as table[0]
  // Row stride.
  if ((char *)&table[1] - (char *)&table[0] != 16) return 4;
  if ((char *)&table[2] - (char *)&table[1] != 16) return 5;
  // Element access.
  if (table[0][0][0] != 'A' || table[0][1][0] != 'B') return 6;
  if (table[1][0][0] != 'C' || table[1][1] != 0) return 7;
  if (table[2][0] != 0 || table[2][1][0] != 'D') return 8;
  // int variant.
  if ((int)sizeof(counts) != 48) return 9;       // 4 rows * 3 ints * 4 bytes
  if ((int)sizeof(counts[0]) != 12) return 10;    // 3 ints * 4 bytes
  if (counts[3][2] != 12) return 11;
  if (counts[1][1] != 5) return 12;
  return 0;
}
