// trigger: __seg_fs
//
// Corroborates the CC_HAS_NAMED_AS probe (arch/x86/Kconfig), which compiles
// `int __seg_fs fs; int __seg_gs gs;`. badc accepts that line -- it reads the
// qualifier as the declarator name -- while rejecting every declaration where
// the qualifier leads the declaration specifiers, which is the only form the
// kernel emits (arch/x86/include/asm/percpu.h __percpu_qual). Without this
// snippet the probe reports a named-address-space support badc does not have.
typedef unsigned long probe_ul;
__seg_gs probe_ul probe_var;
static probe_ul probe_read(__seg_gs probe_ul *p) { return *p; }
