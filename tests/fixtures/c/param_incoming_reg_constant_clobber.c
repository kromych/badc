// A constant defined before a parameter's `ParamRef` must not take that
// parameter's incoming argument register (System V AMD64 3.2.3, AAPCS64
// 6.4.1). With the first parameter unread and the pointer parameter's
// `ParamRef` placed per instruction, the loop bound's literal 5 was
// materialized in `rdx`, where the pointer arrives, before the `ParamRef`
// read it, and the store through the pointer faulted at -O on x86-64.
// The shape is csmith's, reduced; the helpers are its safe-math
// wrappers, verbatim.

#include <stdint.h>

static int8_t safe_lshift_func_int8_t_s_u(int8_t left, unsigned int right)
{
    return ((left < 0) || (((unsigned int)right) >= 32) || (left > (INT8_MAX >> ((unsigned int)right))))
               ? (left)
               : (left << ((unsigned int)right));
}

static int16_t safe_div_func_int16_t_s_s(int16_t si1, int16_t si2)
{
    return ((si2 == 0) || ((si1 == INT16_MIN) && (si2 == (-1)))) ? (si1) : (si1 / si2);
}

static uint64_t safe_mod_func_uint64_t_u_u(uint64_t ui1, uint64_t ui2)
{
    return (ui2 == 0) ? (ui1) : (ui1 % ui2);
}

struct S0 {
    int16_t f2;
} g_137;
int32_t g_6, main_print_hash_value, func_10___trans_tmp_2, g_507, g_76, g_64;
int32_t *g_5 = &g_6;
uint16_t g_79;
uint16_t *g_350 = &g_79;
static struct S0 func_10(int32_t, int8_t, int32_t *, uint32_t, int64_t);
int32_t *func_17(void);

uint32_t func_1(void)
{
    uint16_t l_16 = 5;
    func_10(*g_5, l_16, func_17(), l_16, l_16);
    return 0;
}

struct S0 func_10(int32_t p_11, int8_t p_12, int32_t *p_13, uint32_t p_14, int64_t p_15)
{
    int __trans_tmp_1 = safe_lshift_func_int8_t_s_u(*g_350, 6);
    __trans_tmp_1 = safe_mod_func_uint64_t_u_u(func_10___trans_tmp_2 | p_12, 4);
    safe_div_func_int16_t_s_s(__trans_tmp_1, *g_350);
    p_12;
    for (; g_507 <= 5; g_507++) {
        *p_13 |= 0;
        for (; g_76;)
            ;
    }
    return g_137;
}

int32_t *func_17(void)
{
    return &g_64;
}

int main(void)
{
    func_1();
    return g_64 == 0 && g_507 == 6 ? 0 : 1;
}
