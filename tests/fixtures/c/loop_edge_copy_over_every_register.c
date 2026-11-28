// snapshot-flags: -O -fPIC
// A round function over 16 words that live across its loop: each round
// replaces every word by eight table loads indexed by the bytes of eight
// others. The loop's back edge is a parallel copy of more values than
// x86-64 has general registers, with spill slots at either end, so its
// moves stage through two scratch registers while the copy itself reads
// or writes every other one.
typedef unsigned long long u64;
extern const u64 T[8][256];
void mix(u64 *h, const u64 *in, const u64 *rc) {
    u64 K[8], S[8], L[8];
    for (int i = 0; i < 8; i++) {
        K[i] = h[i];
        S[i] = in[i] ^ K[i];
    }
    for (int r = 0; r < 10; r++) {
        L[0] = T[0][(int)(K[0] >> 56)] ^ T[1][(int)((K[7] >> 48) & 0xff)] ^
               T[2][(int)((K[6] >> 40) & 0xff)] ^ T[3][(int)((K[5] >> 32) & 0xff)] ^
               T[4][(int)((K[4] >> 24) & 0xff)] ^ T[5][(int)((K[3] >> 16) & 0xff)] ^
               T[6][(int)((K[2] >> 8) & 0xff)] ^ T[7][(int)(K[1] & 0xff)] ^
               rc[r];
        L[1] = T[0][(int)(K[1] >> 56)] ^ T[1][(int)((K[0] >> 48) & 0xff)] ^
               T[2][(int)((K[7] >> 40) & 0xff)] ^ T[3][(int)((K[6] >> 32) & 0xff)] ^
               T[4][(int)((K[5] >> 24) & 0xff)] ^ T[5][(int)((K[4] >> 16) & 0xff)] ^
               T[6][(int)((K[3] >> 8) & 0xff)] ^ T[7][(int)(K[2] & 0xff)];
        L[2] = T[0][(int)(K[2] >> 56)] ^ T[1][(int)((K[1] >> 48) & 0xff)] ^
               T[2][(int)((K[0] >> 40) & 0xff)] ^ T[3][(int)((K[7] >> 32) & 0xff)] ^
               T[4][(int)((K[6] >> 24) & 0xff)] ^ T[5][(int)((K[5] >> 16) & 0xff)] ^
               T[6][(int)((K[4] >> 8) & 0xff)] ^ T[7][(int)(K[3] & 0xff)];
        L[3] = T[0][(int)(K[3] >> 56)] ^ T[1][(int)((K[2] >> 48) & 0xff)] ^
               T[2][(int)((K[1] >> 40) & 0xff)] ^ T[3][(int)((K[0] >> 32) & 0xff)] ^
               T[4][(int)((K[7] >> 24) & 0xff)] ^ T[5][(int)((K[6] >> 16) & 0xff)] ^
               T[6][(int)((K[5] >> 8) & 0xff)] ^ T[7][(int)(K[4] & 0xff)];
        L[4] = T[0][(int)(K[4] >> 56)] ^ T[1][(int)((K[3] >> 48) & 0xff)] ^
               T[2][(int)((K[2] >> 40) & 0xff)] ^ T[3][(int)((K[1] >> 32) & 0xff)] ^
               T[4][(int)((K[0] >> 24) & 0xff)] ^ T[5][(int)((K[7] >> 16) & 0xff)] ^
               T[6][(int)((K[6] >> 8) & 0xff)] ^ T[7][(int)(K[5] & 0xff)];
        L[5] = T[0][(int)(K[5] >> 56)] ^ T[1][(int)((K[4] >> 48) & 0xff)] ^
               T[2][(int)((K[3] >> 40) & 0xff)] ^ T[3][(int)((K[2] >> 32) & 0xff)] ^
               T[4][(int)((K[1] >> 24) & 0xff)] ^ T[5][(int)((K[0] >> 16) & 0xff)] ^
               T[6][(int)((K[7] >> 8) & 0xff)] ^ T[7][(int)(K[6] & 0xff)];
        L[6] = T[0][(int)(K[6] >> 56)] ^ T[1][(int)((K[5] >> 48) & 0xff)] ^
               T[2][(int)((K[4] >> 40) & 0xff)] ^ T[3][(int)((K[3] >> 32) & 0xff)] ^
               T[4][(int)((K[2] >> 24) & 0xff)] ^ T[5][(int)((K[1] >> 16) & 0xff)] ^
               T[6][(int)((K[0] >> 8) & 0xff)] ^ T[7][(int)(K[7] & 0xff)];
        L[7] = T[0][(int)(K[7] >> 56)] ^ T[1][(int)((K[6] >> 48) & 0xff)] ^
               T[2][(int)((K[5] >> 40) & 0xff)] ^ T[3][(int)((K[4] >> 32) & 0xff)] ^
               T[4][(int)((K[3] >> 24) & 0xff)] ^ T[5][(int)((K[2] >> 16) & 0xff)] ^
               T[6][(int)((K[1] >> 8) & 0xff)] ^ T[7][(int)(K[0] & 0xff)];
        K[0] = L[0];
        K[1] = L[1];
        K[2] = L[2];
        K[3] = L[3];
        K[4] = L[4];
        K[5] = L[5];
        K[6] = L[6];
        K[7] = L[7];
        L[0] = T[0][(int)(S[0] >> 56)] ^ T[1][(int)((S[7] >> 48) & 0xff)] ^
               T[2][(int)((S[6] >> 40) & 0xff)] ^ T[3][(int)((S[5] >> 32) & 0xff)] ^
               T[4][(int)((S[4] >> 24) & 0xff)] ^ T[5][(int)((S[3] >> 16) & 0xff)] ^
               T[6][(int)((S[2] >> 8) & 0xff)] ^ T[7][(int)(S[1] & 0xff)] ^
               K[0];
        L[1] = T[0][(int)(S[1] >> 56)] ^ T[1][(int)((S[0] >> 48) & 0xff)] ^
               T[2][(int)((S[7] >> 40) & 0xff)] ^ T[3][(int)((S[6] >> 32) & 0xff)] ^
               T[4][(int)((S[5] >> 24) & 0xff)] ^ T[5][(int)((S[4] >> 16) & 0xff)] ^
               T[6][(int)((S[3] >> 8) & 0xff)] ^ T[7][(int)(S[2] & 0xff)] ^
               K[1];
        L[2] = T[0][(int)(S[2] >> 56)] ^ T[1][(int)((S[1] >> 48) & 0xff)] ^
               T[2][(int)((S[0] >> 40) & 0xff)] ^ T[3][(int)((S[7] >> 32) & 0xff)] ^
               T[4][(int)((S[6] >> 24) & 0xff)] ^ T[5][(int)((S[5] >> 16) & 0xff)] ^
               T[6][(int)((S[4] >> 8) & 0xff)] ^ T[7][(int)(S[3] & 0xff)] ^
               K[2];
        L[3] = T[0][(int)(S[3] >> 56)] ^ T[1][(int)((S[2] >> 48) & 0xff)] ^
               T[2][(int)((S[1] >> 40) & 0xff)] ^ T[3][(int)((S[0] >> 32) & 0xff)] ^
               T[4][(int)((S[7] >> 24) & 0xff)] ^ T[5][(int)((S[6] >> 16) & 0xff)] ^
               T[6][(int)((S[5] >> 8) & 0xff)] ^ T[7][(int)(S[4] & 0xff)] ^
               K[3];
        L[4] = T[0][(int)(S[4] >> 56)] ^ T[1][(int)((S[3] >> 48) & 0xff)] ^
               T[2][(int)((S[2] >> 40) & 0xff)] ^ T[3][(int)((S[1] >> 32) & 0xff)] ^
               T[4][(int)((S[0] >> 24) & 0xff)] ^ T[5][(int)((S[7] >> 16) & 0xff)] ^
               T[6][(int)((S[6] >> 8) & 0xff)] ^ T[7][(int)(S[5] & 0xff)] ^
               K[4];
        L[5] = T[0][(int)(S[5] >> 56)] ^ T[1][(int)((S[4] >> 48) & 0xff)] ^
               T[2][(int)((S[3] >> 40) & 0xff)] ^ T[3][(int)((S[2] >> 32) & 0xff)] ^
               T[4][(int)((S[1] >> 24) & 0xff)] ^ T[5][(int)((S[0] >> 16) & 0xff)] ^
               T[6][(int)((S[7] >> 8) & 0xff)] ^ T[7][(int)(S[6] & 0xff)] ^
               K[5];
        L[6] = T[0][(int)(S[6] >> 56)] ^ T[1][(int)((S[5] >> 48) & 0xff)] ^
               T[2][(int)((S[4] >> 40) & 0xff)] ^ T[3][(int)((S[3] >> 32) & 0xff)] ^
               T[4][(int)((S[2] >> 24) & 0xff)] ^ T[5][(int)((S[1] >> 16) & 0xff)] ^
               T[6][(int)((S[0] >> 8) & 0xff)] ^ T[7][(int)(S[7] & 0xff)] ^
               K[6];
        L[7] = T[0][(int)(S[7] >> 56)] ^ T[1][(int)((S[6] >> 48) & 0xff)] ^
               T[2][(int)((S[5] >> 40) & 0xff)] ^ T[3][(int)((S[4] >> 32) & 0xff)] ^
               T[4][(int)((S[3] >> 24) & 0xff)] ^ T[5][(int)((S[2] >> 16) & 0xff)] ^
               T[6][(int)((S[1] >> 8) & 0xff)] ^ T[7][(int)(S[0] & 0xff)] ^
               K[7];
        S[0] = L[0];
        S[1] = L[1];
        S[2] = L[2];
        S[3] = L[3];
        S[4] = L[4];
        S[5] = L[5];
        S[6] = L[6];
        S[7] = L[7];
    }
    for (int i = 0; i < 8; i++) {
        h[i] ^= S[i] ^ in[i];
    }
}

const u64 T[8][256] = {
    [0][1] = 0x9e3779b97f4a7c15ULL, [0][0x5a] = 0xbf58476d1ce4e5b9ULL,
    [1][2] = 0x94d049bb133111ebULL, [1][0xc3] = 0x2545f4914f6cdd1dULL,
    [2][3] = 0xd6e8feb86659fd93ULL, [2][0x17] = 0xff51afd7ed558ccdULL,
    [3][4] = 0xc4ceb9fe1a85ec53ULL, [3][0x88] = 0x9fb21c651e98df25ULL,
    [4][5] = 0x2127599bf4325c37ULL, [4][0xe1] = 0x880355f21e6d1965ULL,
    [5][6] = 0x165667b19e3779f9ULL, [5][0x3c] = 0x27d4eb2f165667c5ULL,
    [6][7] = 0x85ebca77c2b2ae63ULL, [6][0xa4] = 0xc2b2ae3d27d4eb4fULL,
    [7][8] = 0x61c8864680b583ebULL, [7][0x6f] = 0x9e6c63d0876a9a47ULL,
};

int main(void) {
    u64 h[8], in[8], rc[10];
    for (int i = 0; i < 8; i++) {
        h[i] = 0x0101010101010101ULL * (i + 1);
        in[i] = 0x0807060504030201ULL << i;
    }
    for (int i = 0; i < 10; i++) {
        rc[i] = 0x5a5a5a5a5a5a5a5aULL >> i;
    }
    mix(h, in, rc);
    mix(h, in, rc);
    u64 sum = 0;
    for (int i = 0; i < 8; i++) {
        sum = sum * 31 + h[i];
    }
    return sum == 0x515151514a736c84ULL ? 0 : 1;
}
