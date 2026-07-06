// A `float` parameter past the FP argument registers rides the host
// stack at single precision (System V AMD64 3.2.3 / AAPCS64 6.4.1);
// Win64 overflows after four positional slots. The callee reads the
// cell back as an f32 bit pattern, so a caller storing a widened
// double there yields 0.0f. Weighted positions catch a dropped or
// permuted overflow slot, direct and through a function pointer.

static int wsum(float a, float b, float c, float d, float e,
                float f, float g, float h, float i, float j) {
    return (int)(a * 1.0f + b * 2.0f + c * 4.0f + d * 8.0f + e * 16.0f +
                 f * 32.0f + g * 64.0f + h * 128.0f + i * 256.0f + j * 512.0f);
}

typedef int (*wf)(float, float, float, float, float,
                  float, float, float, float, float);

volatile float fone = 1.0f;

int main(void) {
    float v = fone;
    int d = wsum(v, v, v, v, v, v, v, v, v, v);
    /* 1+2+4+8+16+32+64+128+256+512 */
    if (d != 1023) return 1;
    wf p = wsum;
    int r = p(v, v, v, v, v, v, v, v, 1.5f, 0.5f);
    /* 255 + 1.5*256 + 0.5*512 = 255 + 384 + 256 */
    if (r != 895) return 2;
    return 0;
}
