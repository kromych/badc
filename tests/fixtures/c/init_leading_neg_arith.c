// C99 6.7.8 initializer with a leading-`-` integer expression
// inside a struct-array element. badc's
// `parse_constant_init_value` fast-path used to consume `-N` and
// return -- leaving any trailing `* M` / `+ M` to be misread by
// the brace-list parser as additional struct fields, surfacing
// `too many initializers for struct ...`. The fast-path now
// rewinds and routes the leading `-Num` through the full
// `parse_constant_int` precedence chain so the whole expression
// folds in place.

static struct {
    char *name;
    int v;
} zones[] = {
    { "A", -5 * 3600 },
    { "B", -6 * 3600 },
    { "C", -7 * 3600 + 60 },
    { "D", -8 - 1 },
};

int main(void) {
    if (zones[0].v != -18000) return 1;
    if (zones[1].v != -21600) return 2;
    if (zones[2].v != -25140) return 3;
    if (zones[3].v != -9) return 4;
    return 0;
}
