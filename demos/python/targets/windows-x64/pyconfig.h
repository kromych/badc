/* badc Windows target overrides, appended to the source distribution's
   PC/pyconfig.h (which ships in the tarball and carries the Windows
   configuration). These lines change the parts the badc build needs
   different from the MSVC defaults. */

/* pymalloc instead of mimalloc: mimalloc's per-thread heap initializes a
   thread-local pointer with the address of a global, a relocation against the
   TLS template badc does not emit. */
#undef WITH_MIMALLOC

/* sys.version reports the build compiler. badc presents the GNU C surface, so
   getcompiler.c would otherwise report GCC; name the actual compiler. */
#undef COMPILER
#define COMPILER "[badc]"
