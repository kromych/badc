/* An asm label gives a declaration an assembler name distinct from its C name.
 * badc: "assembler name `strnlen' differing from `__real_strnlen' is not yet
 * supported". gcc and clang accept it.
 *
 * Reached by every unit of a kernel configuration that sets FORTIFY_SOURCE:
 * the fortified string header declares one of these per wrapped function.
 */
extern unsigned long __real_strnlen(const char *, unsigned long) __asm__("strnlen");

unsigned long f(const char *p)
{
	return __real_strnlen(p, 8);
}
