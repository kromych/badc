// Stub init functions for built-in modules excluded from this minimal
// build. PC/config.c's inittab references each PyInit_*; without a
// definition the link fails. Returning NULL makes `import <mod>` raise
// rather than link-fail. None of these modules are used by the test slice.
//
// Excluded (see win_build.py): mmap, cmath, _hmac.

typedef void PyObject;

PyObject *PyInit_mmap(void)   { return 0; }
PyObject *PyInit_cmath(void)  { return 0; }
PyObject *PyInit__hmac(void)  { return 0; }
