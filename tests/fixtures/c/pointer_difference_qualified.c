// Differences of pointers whose pointees differ only in their qualifiers
// (C99 6.5.6p3), beside a pointer minus an integer.

typedef unsigned int Instruction;
struct Proto { Instruction *code; };

long pc_relative(const Instruction *pc, const struct Proto *p)
{
    return pc - p->code - 1;
}

long unqualified_left(Instruction *a, const Instruction *b) { return a - b; }
long volatile_right(unsigned char *a, volatile unsigned char *b) { return a - b; }
long wide_elements(const double *a, double *b) { return a - b; }
const Instruction *back(const Instruction *a, long n) { return a - n; }

int main(void)
{
    Instruction code[8];
    double d[4];
    unsigned char bytes[6];
    struct Proto p = {code};
    long r = pc_relative(&code[6], &p) - 5;
    r += unqualified_left(&code[3], code) - 3;
    r += volatile_right(&bytes[5], bytes) - 5;
    r += wide_elements(&d[2], d) - 2;
    r += back(&code[4], 4) != code;
    return (int)r;
}
