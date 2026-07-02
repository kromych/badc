/* A constant pointer offset folded into a floating load's displacement
   must reach the emitted access: the load reads *(base + c), not *base.
   The struct places float and double members at nonzero offsets; the
   read-modify-write shares one folded address between a load and a
   store. */
struct pack {
    long tag;
    float f;   /* offset 8 */
    double d;  /* offset 16 */
    float g[3]; /* offsets 24, 28, 32 */
};

static float read_f(struct pack *p) { return p->f; }
static double read_d(struct pack *p) { return p->d; }
static float read_g2(struct pack *p) { return p->g[2]; }
static void bump_d(struct pack *p) { p->d = p->d + 0.5; }

int main(void) {
    struct pack p;
    p.tag = -1;
    p.f = 1.25f;
    p.d = 2.5;
    p.g[0] = 0.0f;
    p.g[1] = 0.0f;
    p.g[2] = 4.75f;
    if (read_f(&p) != 1.25f) {
        return 1;
    }
    if (read_d(&p) != 2.5) {
        return 2;
    }
    if (read_g2(&p) != 4.75f) {
        return 3;
    }
    bump_d(&p);
    if (p.d != 3.0) {
        return 4;
    }
    return 0;
}
