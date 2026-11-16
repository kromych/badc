// `-O` predefines `__OPTIMIZE__` as 1 and leaves `NDEBUG` to the command
// line, as gcc and clang do; `-D` and `-U` override the predefine. The exit
// code reports what the preprocessor saw: NDEBUG defined -> 101,
// otherwise `__OPTIMIZE__`'s value, or 100 when neither is defined.

#ifdef NDEBUG
int main(void) { return 101; }
#elif defined(__OPTIMIZE__)
int main(void) { return __OPTIMIZE__; }
#else
int main(void) { return 100; }
#endif
