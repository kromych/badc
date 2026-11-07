// The `lpCmdLine` a `WinMain` receives is the command line past the program
// name, as cl's CRT passes it, so a run with no arguments receives "".
#ifdef _WIN32
int WinMain(void *instance, void *prev, char *cmd_line, int show) {
    (void)instance;
    (void)prev;
    (void)show;
    return cmd_line[0] == 0 ? 0 : 1;
}
#else
int main(void) { return 0; }
#endif
