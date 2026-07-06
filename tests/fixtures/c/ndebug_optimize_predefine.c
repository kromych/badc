// `-O` predefines `NDEBUG` and `__OPTIMIZE__` (both 1, following the
// gcc/clang convention for the latter); explicit `-D` / `-U` flags
// override the implied values. The exit code reports what the
// preprocessor saw: both defined -> the NDEBUG value, exactly one
// defined -> 101, neither -> 100.

#if defined(NDEBUG) && defined(__OPTIMIZE__)
int main(void) { return NDEBUG; }
#elif defined(NDEBUG) || defined(__OPTIMIZE__)
int main(void) { return 101; }
#else
int main(void) { return 100; }
#endif
