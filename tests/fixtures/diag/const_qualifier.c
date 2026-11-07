/* The const-qualifier rules of C17, one case per construct. Each case below a
 * `//== <name>: <verdict>` line is compiled after this prelude on every
 * target; the verdict is `ok` (no diagnostic), or `error` / `warning` and the
 * diagnostic's selector. */
#include <stdarg.h>
#include <stdlib.h>
#include <string.h>

struct inner { int v; };
struct holder { int a; const int b; struct inner in; };
struct deep { struct holder h; };
struct plain { int a; int b; };
union carrier { const int c; int i; };
typedef const int cint;
typedef int row[2];
static const int k = 1;
static const int table[3] = { 1, 2, 3 };
static const struct plain cplain = { 1, 2 };
int take(int *p);
int take_c(const int *p);
int take_pp(const char **pp);
int take_cpc(const char *const *pp);
int take_v(void *p);

//== assign_const_object: error modifiable-lvalue
void f(void) { const int x = 1; x = 2; }
//== compound_assign_const_object: error modifiable-lvalue
void f(void) { const int x = 1; x += 2; }
//== increment_const_object: error modifiable-lvalue
void f(void) { const int x = 1; x++; }
//== decrement_prefix_const_object: error modifiable-lvalue
void f(void) { const int x = 1; --x; }
//== assign_file_scope_const: error modifiable-lvalue
void f(void) { k = 2; }
//== assign_const_typedef: error modifiable-lvalue
void f(void) { cint x = 1; x = 2; }
//== assign_const_parameter: error modifiable-lvalue
void f(const int p) { p = 2; }
//== assign_const_array_element: error modifiable-lvalue
void f(void) { table[1] = 4; }
//== assign_const_2d_array_element: error modifiable-lvalue
void f(void) { const int m[2][2] = { { 1, 2 }, { 3, 4 } }; m[1][0] = 5; }
//== assign_const_typedef_array_element: error modifiable-lvalue
void f(void) { const row r = { 1, 2 }; r[0] = 3; }
//== assign_through_pointer_to_const: error modifiable-lvalue
void f(const int *p) { *p = 1; }
//== assign_through_pointer_to_const_subscript: error modifiable-lvalue
void f(const int *p) { p[2] = 1; }
//== assign_const_pointer_itself: error modifiable-lvalue
void f(int *const p) { p = 0; }
//== assign_through_const_pointer: ok
void f(int *const p) { *p = 1; }
//== assign_member_of_const_struct: error modifiable-lvalue
void f(void) { cplain.a = 3; }
//== assign_member_through_pointer_to_const_struct: error modifiable-lvalue
void f(const struct plain *p) { p->b = 3; }
//== assign_const_member: error modifiable-lvalue
void f(struct holder *h) { h->b = 3; }
//== assign_nonconst_member_beside_const_one: ok
void f(struct holder *h) { h->a = 3; h->in.v = 4; }
//== assign_nested_member_of_const_struct: error modifiable-lvalue
void f(const struct deep *d) { d->h.in.v = 1; }
//== assign_struct_with_const_member: error modifiable-lvalue
void f(struct holder *x, struct holder *y) { *x = *y; }
//== assign_struct_with_nested_const_member: error modifiable-lvalue
void f(struct deep *x, struct deep *y) { *x = *y; }
//== assign_union_with_const_member: error modifiable-lvalue
void f(union carrier *x, union carrier *y) { *x = *y; }
//== assign_const_compound_literal_member: error modifiable-lvalue
void f(void) { ((const struct plain){ 1, 2 }).a = 3; }
//== assign_typeof_const_object: error modifiable-lvalue
void f(void) { const int x = 1; __typeof__(x) y = 2; y = 3; }
//== assign_const_atomic_object: error modifiable-lvalue
void f(void) { const _Atomic int x = 1; x = 2; }
//== assign_inside_sizeof_is_still_checked: error modifiable-lvalue
int f(void) { const int x = 1; return (int)sizeof(x = 2); }
//== assign_const_bitfield: error modifiable-lvalue
struct bits { const unsigned f : 3; };
void g(struct bits *b) { b->f = 1; }
//== cast_away_const_then_assign: ok
void f(const int *p) { *(int *)p = 1; }
//== read_const_objects: ok
int f(const int *p, const struct holder *h) { return *p + h->b + table[2] + k + cplain.b; }
//== initialize_const_object: ok
void f(void) { const int x = 1; const struct holder h = { 1, 2, { 3 } }; (void)x; (void)h; }
//== initializer_discards_const: warning discarded-qualifiers
void f(const int *p) { int *q = p; (void)q; }
//== assignment_discards_const: warning discarded-qualifiers
void f(const int *p) { int *q; q = p; (void)q; }
//== argument_discards_const: warning discarded-qualifiers
int f(const int *p) { return take(p); }
//== argument_adds_const: ok
int f(int *p) { return take_c(p); }
//== return_discards_const: warning discarded-qualifiers
int *f(const int *p) { return p; }
//== void_pointer_discards_const: warning discarded-qualifiers
int f(const int *p) { return take_v((const void *)p); }
//== conditional_result_keeps_const: warning discarded-qualifiers
int *f(int c, int *a, const int *b) { return c ? a : b; }
//== comma_result_keeps_const: warning discarded-qualifiers
int *f(const int *p) { return (0, p); }
//== address_of_const_object_discards: warning discarded-qualifiers
int *f(void) { int *p = &k; return p; }
//== const_array_decays_to_pointer_to_const: warning discarded-qualifiers
int *f(void) { int *p = table; return p; }
//== string_literal_to_char_pointer: ok
char *f(void) { return "text"; }
//== pointer_to_pointer_gains_inner_const: warning incompatible-pointer-types-discards-qualifiers
int f(char **pp) { return take_pp(pp); }
//== pointer_to_pointer_gains_both_consts: warning incompatible-pointer-types-discards-qualifiers
int f(char **pp) { return take_cpc(pp); }
//== library_argument_discards_const: warning discarded-qualifiers
void f(const char *d) { memset(d, 0, 1); }
//== library_free_of_pointer_to_const: warning discarded-qualifiers
void f(const char *d) { free(d); }
//== library_source_takes_const: ok
void f(char *d, const char *s) { strcpy(d, s); memcpy(d, s, 1); }
//== builtin_argument_discards_const: warning discarded-qualifiers
void f(const char *d, char *s) { __builtin_strcpy(d, s); }
//== atomic_store_through_pointer_to_const: error modifiable-lvalue
void f(const int *p) { __atomic_store_n(p, 1, __ATOMIC_SEQ_CST); }
//== atomic_rmw_through_pointer_to_const: error modifiable-lvalue
int f(const int *p) { return __atomic_fetch_add(p, 1, __ATOMIC_SEQ_CST); }
//== sync_rmw_through_pointer_to_const: error modifiable-lvalue
int f(const int *p) { return __sync_fetch_and_add(p, 1); }
//== atomic_load_through_pointer_to_const: ok
int f(const int *p) { return __atomic_load_n(p, __ATOMIC_SEQ_CST); }
//== atomic_load_result_through_pointer_to_const: warning discarded-qualifiers
void f(int *p, const int *r) { __atomic_load(p, r, __ATOMIC_SEQ_CST); }
//== atomic_cmpxchg_expected_through_pointer_to_const: warning discarded-qualifiers
int f(int *p, const int *e) { return __atomic_compare_exchange_n(p, e, 1, 0, __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST); }
//== asm_output_const_object: error modifiable-lvalue
void f(void) { const int x = 1; __asm__("" : "=r"(x)); }
//== asm_inout_const_object: error modifiable-lvalue
void f(void) { const int x = 1; __asm__("" : "+r"(x)); }
//== asm_input_const_object: ok
void f(void) { const int x = 1; __asm__("" : : "r"(x)); }
//== va_start_const_va_list: error modifiable-lvalue
void f(int n, ...) { const va_list ap; va_start(ap, n); }
//== va_copy_into_const_va_list: error modifiable-lvalue
void f(int n, ...) { va_list ap; const va_list cp; va_start(ap, n); va_copy(cp, ap); va_end(ap); }
//== va_list_use: ok
int f(int n, ...) { va_list ap, cp; va_start(ap, n); va_copy(cp, ap); int v = va_arg(cp, int); va_end(cp); va_end(ap); return v; }
//== generic_selects_unqualified_type: ok
_Static_assert(_Generic((const int)1, int: 1, default: 0), "lvalue conversion drops const");
//== generic_selects_pointer_to_const: ok
_Static_assert(_Generic(&k, const int *: 1, int *: 2, default: 0) == 1, "pointer to const");
//== redeclaration_differs_in_const: error invalid-declaration
extern int g;
extern const int g;
//== function_pointer_return_gains_const: error incompatible-pointer-types
const int *g(void);
int *(*fp)(void) = g;
//== function_pointer_return_loses_const: error incompatible-pointer-types
int *g(void);
const int *(*fp)(void) = g;
//== function_pointer_return_argument_differs_in_const: error incompatible-pointer-types
const int *g(void);
void h(int *(*)(void));
void use(void) { h(g); }
//== function_return_type_drops_its_own_qualifier: ok
const int g(void);
int (*fp)(void) = g;
//== function_pointer_object_may_be_const: ok
int *g(void);
int *(*const fp)(void) = g;
//== assign_function_designator: error invalid-operands
int *g(void);
void use(void) { int *(*fp)(void) = g; *fp = 0; }
//== increment_function_designator: error invalid-operands
int *g(void);
void use(void) { int *(*fp)(void) = g; (*fp)++; }
//== compound_assign_function_designator: error invalid-operands
int *g(void);
void use(void) { int *(*fp)(void) = g; *fp += 1; }
//== function_designator_reads: ok
int *g(void);
int *use(void) { int *(*fp)(void) = g; int *(*q)(void) = &*fp; fp = *fp; return (*q)(); }
//== write_through_pointer_to_function_pointer: ok
int *g(void);
void use(void) { int *(*fp)(void) = g; int *(**pp)(void) = &fp; *pp = g; }
