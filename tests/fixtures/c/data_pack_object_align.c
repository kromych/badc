// snapshot-flags: -c
// Static data packs at each object's own alignment. The page-aligned
// object does not push its neighbours onto page boundaries, and the
// objects the data prune drops leave no padding behind. The relocation
// addends below are the packed offsets, so this fixture locks the
// layout the compaction produces.

_Alignas(4096) long page_data[512] = {1};
_Alignas(64) long cache_line[8] = {2};
long plain[3] = {3};
long zero_fill[8];

static long unused_init[16] = {4};
static long unused_zero[16];

long sum(void) {
    return page_data[0] + cache_line[0] + plain[0] + zero_fill[0];
}

long *cache_addr(void) { return cache_line; }
