// The `lpCmdLine` a `wWinMain` receives is the command line past the
// program name, as cl's CRT passes it, so a run with no arguments
// receives L"".
#ifdef _WIN32
int wWinMain(void *instance, void *prev, unsigned short *cmd_line, int show) {
    (void)instance;
    (void)prev;
    (void)show;
    return cmd_line[0] == 0 ? 0 : 1;
}
#else
int main(void) { return 0; }
#endif
