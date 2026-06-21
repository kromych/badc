// Windows console entry for the badc-built interpreter.
//
// badc's runtime entry stub calls main(); on Windows the interpreter's
// argv must be the wide command line, since Py_Main takes wchar_t**.
#include <windows.h>

#pragma dylib(shell32, "shell32.dll")
#pragma binding(shell32::CommandLineToArgvW, "CommandLineToArgvW")
#pragma binding(kernel32::GetCommandLineW, "GetCommandLineW")

extern int Py_Main(int argc, unsigned short **argv);
unsigned short **CommandLineToArgvW(const unsigned short *cmdline, int *argc);
const unsigned short *GetCommandLineW(void);

int main(void) {
    int argc = 0;
    unsigned short **argv = CommandLineToArgvW(GetCommandLineW(), &argc);
    return Py_Main(argc, argv);
}
