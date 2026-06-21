// Stub init functions for built-in modules excluded from this minimal
// build. PC/config.c's inittab references each PyInit_*; without a
// definition the link fails. Returning NULL makes `import <mod>` raise
// rather than link-fail. None of these modules are used by the test slice.
//
// Excluded (see build.py): mmap, _hmac.

typedef void PyObject;

PyObject *PyInit_mmap(void)   { return 0; }
PyObject *PyInit__hmac(void)  { return 0; }

// PC/dl_nt.c defines these globals only for the DLL build (Py_ENABLE_SHARED).
// The static interpreter still registers sys.winver / sys.dllhandle from them
// under MS_COREDLL (sysmodule.c), so provide them: there is no Python DLL, so
// the module handle is null and the version string is MS_DLL_ID (X.Y).
// build.py passes -DMS_DLL_ID; the fallback only lets this file parse
// standalone (the build value always wins).
#ifndef MS_DLL_ID
#define MS_DLL_ID "0.0"
#endif
const char *PyWin_DLLVersionString = MS_DLL_ID;
void *PyWin_DLLhModule = 0;
