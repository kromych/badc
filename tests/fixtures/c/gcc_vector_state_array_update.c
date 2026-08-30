// The shape the kernel's AEGIS-128 NEON unit is built from: a five-element
// array of 16-byte vectors carried in a struct, loaded from memory into a
// brace list of whole-vector values, threaded through a by-value update, and
// stored back. Each step is checked against a scalar loop over the same
// bytes, and a message split into two chunks must leave the same state as
// the same message processed in one -- the property a chunked AEAD depends on.

typedef unsigned char u8x16 __attribute__((vector_size(16)));

#define N 5

struct state {
    u8x16 v[N];
};

static u8x16 load16(const unsigned char *p) {
    u8x16 r;
    for (int i = 0; i < 16; i++) r[i] = p[i];
    return r;
}

static void store16(unsigned char *p, u8x16 v) {
    for (int i = 0; i < 16; i++) p[i] = v[i];
}

// A one-instruction-per-lane mix, standing in for the AES round: the same
// carry-less doubling the AEGIS mix-columns step uses, plus a constant.
static u8x16 mix(u8x16 w) {
    return (u8x16)((w << 1) ^ ((w >> 7) * 0x1b) ^ 0x63);
}

static unsigned char mix_scalar(unsigned char w) {
    return (unsigned char)((w << 1) ^ ((w >> 7) * 0x1b) ^ 0x63);
}

static struct state load_state(const unsigned char *p) {
    return (struct state){{load16(p), load16(p + 16), load16(p + 32),
                           load16(p + 48), load16(p + 64)}};
}

static void save_state(struct state s, unsigned char *p) {
    for (int i = 0; i < N; i++) store16(p + 16 * i, s.v[i]);
}

static struct state update(struct state s, u8x16 m) {
    m ^= mix(s.v[4]);
    s.v[4] ^= mix(s.v[3]);
    s.v[3] ^= mix(s.v[2]);
    s.v[2] ^= mix(s.v[1]);
    s.v[1] ^= mix(s.v[0]);
    s.v[0] ^= m;
    return s;
}

static void update_scalar(unsigned char st[N][16], const unsigned char *msg) {
    unsigned char m[16];
    for (int i = 0; i < 16; i++) m[i] = msg[i] ^ mix_scalar(st[4][i]);
    for (int k = 4; k > 0; k--)
        for (int i = 0; i < 16; i++) st[k][i] ^= mix_scalar(st[k - 1][i]);
    for (int i = 0; i < 16; i++) st[0][i] ^= m[i];
}

// Run `blocks` 16-byte messages from `msg` through the vector path, carrying
// the state through memory between chunks exactly as a chunked AEAD does.
static void run_chunk(unsigned char *state, const unsigned char *msg, int blocks) {
    struct state s = load_state(state);
    for (int b = 0; b < blocks; b++) s = update(s, load16(msg + 16 * b));
    save_state(s, state);
}

int main(void) {
    unsigned char seed[N * 16], msg[8 * 16];
    for (int i = 0; i < N * 16; i++) seed[i] = (unsigned char)(i * 7 + 1);
    for (int i = 0; i < 8 * 16; i++) msg[i] = (unsigned char)(i * 31 + 9);

    // The scalar reference over all eight blocks.
    unsigned char ref[N][16];
    for (int k = 0; k < N; k++)
        for (int i = 0; i < 16; i++) ref[k][i] = seed[16 * k + i];
    for (int b = 0; b < 8; b++) update_scalar(ref, msg + 16 * b);

    // One contiguous run.
    unsigned char whole[N * 16];
    for (int i = 0; i < N * 16; i++) whole[i] = seed[i];
    run_chunk(whole, msg, 8);
    for (int k = 0; k < N; k++)
        for (int i = 0; i < 16; i++)
            if (whole[16 * k + i] != ref[k][i]) return 1;

    // The same message split at every block boundary must agree with it.
    for (int cut = 0; cut <= 8; cut++) {
        unsigned char split[N * 16];
        for (int i = 0; i < N * 16; i++) split[i] = seed[i];
        run_chunk(split, msg, cut);
        run_chunk(split, msg + 16 * cut, 8 - cut);
        for (int i = 0; i < N * 16; i++)
            if (split[i] != whole[i]) return 2 + cut;
    }

    // A state array built from whole-vector values held in variables, not
    // read from memory, takes the same path through the initializer.
    u8x16 a = load16(seed), b = load16(seed + 16), c = load16(seed + 32);
    u8x16 d = load16(seed + 48), e = load16(seed + 64);
    struct state direct = {{a, b, c, d, e}};
    unsigned char out[N * 16];
    save_state(update(direct, load16(msg)), out);

    unsigned char ref1[N][16];
    for (int k = 0; k < N; k++)
        for (int i = 0; i < 16; i++) ref1[k][i] = seed[16 * k + i];
    update_scalar(ref1, msg);
    for (int k = 0; k < N; k++)
        for (int i = 0; i < 16; i++)
            if (out[16 * k + i] != ref1[k][i]) return 20;

    return 0;
}
