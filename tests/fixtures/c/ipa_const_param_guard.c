// A build-time assert whose operand is a parameter is constant only
// from the call sites: C99 6.9.1p10 makes the arguments the parameters'
// initial values, and a file-scope `static` function (6.2.2) is reached
// only through the sites this translation unit holds. When they all
// pass the same constant, the guard has a translation-time answer and
// must leave no call behind.
//
// `compiletime_assert_331` is declared and never defined, so linking is
// the assertion. The callee is deliberately too large to inline -- the
// constant has to reach the guard interprocedurally, not by
// substitution at a splice. gcc 16 links this at -O2 and, like badc,
// fails to at -O0.

#define BUILD_BUG_ON(cond, tag)                                                                    \
    do {                                                                                           \
        extern void compiletime_assert_##tag(void);                                                \
        if (!(!(cond)))                                                                            \
            compiletime_assert_##tag();                                                            \
    } while (0)

#define END_OF_FIXED_ADDRESSES 974
#define FIX_TEXT_POKE0 3

static long table[180];

static long patch_map(long addr, int fixmap) {
    long acc = 0;
    BUILD_BUG_ON(fixmap >= END_OF_FIXED_ADDRESSES, 331);
    acc += table[0] * 1;
    acc += table[1] * 2;
    acc += table[2] * 3;
    acc += table[3] * 4;
    acc += table[4] * 5;
    acc += table[5] * 6;
    acc += table[6] * 7;
    acc += table[7] * 8;
    acc += table[8] * 9;
    acc += table[9] * 10;
    acc += table[10] * 11;
    acc += table[11] * 12;
    acc += table[12] * 13;
    acc += table[13] * 14;
    acc += table[14] * 15;
    acc += table[15] * 16;
    acc += table[16] * 17;
    acc += table[17] * 18;
    acc += table[18] * 19;
    acc += table[19] * 20;
    acc += table[20] * 21;
    acc += table[21] * 22;
    acc += table[22] * 23;
    acc += table[23] * 24;
    acc += table[24] * 25;
    acc += table[25] * 26;
    acc += table[26] * 27;
    acc += table[27] * 28;
    acc += table[28] * 29;
    acc += table[29] * 30;
    acc += table[30] * 31;
    acc += table[31] * 32;
    acc += table[32] * 33;
    acc += table[33] * 34;
    acc += table[34] * 35;
    acc += table[35] * 36;
    acc += table[36] * 37;
    acc += table[37] * 38;
    acc += table[38] * 39;
    acc += table[39] * 40;
    acc += table[40] * 41;
    acc += table[41] * 42;
    acc += table[42] * 43;
    acc += table[43] * 44;
    acc += table[44] * 45;
    acc += table[45] * 46;
    acc += table[46] * 47;
    acc += table[47] * 48;
    acc += table[48] * 49;
    acc += table[49] * 50;
    acc += table[50] * 51;
    acc += table[51] * 52;
    acc += table[52] * 53;
    acc += table[53] * 54;
    acc += table[54] * 55;
    acc += table[55] * 56;
    acc += table[56] * 57;
    acc += table[57] * 58;
    acc += table[58] * 59;
    acc += table[59] * 60;
    acc += table[60] * 61;
    acc += table[61] * 62;
    acc += table[62] * 63;
    acc += table[63] * 64;
    acc += table[64] * 65;
    acc += table[65] * 66;
    acc += table[66] * 67;
    acc += table[67] * 68;
    acc += table[68] * 69;
    acc += table[69] * 70;
    acc += table[70] * 71;
    acc += table[71] * 72;
    acc += table[72] * 73;
    acc += table[73] * 74;
    acc += table[74] * 75;
    acc += table[75] * 76;
    acc += table[76] * 77;
    acc += table[77] * 78;
    acc += table[78] * 79;
    acc += table[79] * 80;
    acc += table[80] * 81;
    acc += table[81] * 82;
    acc += table[82] * 83;
    acc += table[83] * 84;
    acc += table[84] * 85;
    acc += table[85] * 86;
    acc += table[86] * 87;
    acc += table[87] * 88;
    acc += table[88] * 89;
    acc += table[89] * 90;
    acc += table[90] * 91;
    acc += table[91] * 92;
    acc += table[92] * 93;
    acc += table[93] * 94;
    acc += table[94] * 95;
    acc += table[95] * 96;
    acc += table[96] * 97;
    acc += table[97] * 98;
    acc += table[98] * 99;
    acc += table[99] * 100;
    acc += table[100] * 101;
    acc += table[101] * 102;
    acc += table[102] * 103;
    acc += table[103] * 104;
    acc += table[104] * 105;
    acc += table[105] * 106;
    acc += table[106] * 107;
    acc += table[107] * 108;
    acc += table[108] * 109;
    acc += table[109] * 110;
    acc += table[110] * 111;
    acc += table[111] * 112;
    acc += table[112] * 113;
    acc += table[113] * 114;
    acc += table[114] * 115;
    acc += table[115] * 116;
    acc += table[116] * 117;
    acc += table[117] * 118;
    acc += table[118] * 119;
    acc += table[119] * 120;
    acc += table[120] * 121;
    acc += table[121] * 122;
    acc += table[122] * 123;
    acc += table[123] * 124;
    acc += table[124] * 125;
    acc += table[125] * 126;
    acc += table[126] * 127;
    acc += table[127] * 128;
    acc += table[128] * 129;
    acc += table[129] * 130;
    acc += table[130] * 131;
    acc += table[131] * 132;
    acc += table[132] * 133;
    acc += table[133] * 134;
    acc += table[134] * 135;
    acc += table[135] * 136;
    acc += table[136] * 137;
    acc += table[137] * 138;
    acc += table[138] * 139;
    acc += table[139] * 140;
    acc += table[140] * 141;
    acc += table[141] * 142;
    acc += table[142] * 143;
    acc += table[143] * 144;
    acc += table[144] * 145;
    acc += table[145] * 146;
    acc += table[146] * 147;
    acc += table[147] * 148;
    acc += table[148] * 149;
    acc += table[149] * 150;
    acc += table[150] * 151;
    acc += table[151] * 152;
    acc += table[152] * 153;
    acc += table[153] * 154;
    acc += table[154] * 155;
    acc += table[155] * 156;
    acc += table[156] * 157;
    acc += table[157] * 158;
    acc += table[158] * 159;
    acc += table[159] * 160;
    acc += table[160] * 161;
    acc += table[161] * 162;
    acc += table[162] * 163;
    acc += table[163] * 164;
    acc += table[164] * 165;
    acc += table[165] * 166;
    acc += table[166] * 167;
    acc += table[167] * 168;
    acc += table[168] * 169;
    acc += table[169] * 170;
    acc += table[170] * 171;
    acc += table[171] * 172;
    acc += table[172] * 173;
    acc += table[173] * 174;
    acc += table[174] * 175;
    acc += table[175] * 176;
    acc += table[176] * 177;
    acc += table[177] * 178;
    acc += table[178] * 179;
    acc += table[179] * 180;
    return acc + addr + fixmap;
}

long map_a(long p);
long map_b(long p);
long map_a(long p) {
    return patch_map(p, FIX_TEXT_POKE0);
}
long map_b(long p) {
    return patch_map(p, FIX_TEXT_POKE0);
}

// A second static whose sites disagree on the argument: its parameter
// is not a constant and the body must still answer per call.
static int clamp_to(int v, int hi) {
    return v > hi ? hi : v;
}

int main(void) {
    long want = 0;
    int i;
    for (i = 0; i < 180; i++)
        table[i] = i;
    for (i = 0; i < 180; i++)
        want += table[i] * (i + 1);
    want += 7 + FIX_TEXT_POKE0;
    if (map_a(7) != want)
        return 1;
    if (map_b(7) != want)
        return 2;
    if (clamp_to(5, 4) != 4 || clamp_to(1, 9) != 1)
        return 3;
    return 0;
}

