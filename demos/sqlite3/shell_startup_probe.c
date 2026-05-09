/*
** shell.c-startup-sequence probe. Replicates the first few lines
** of shell.c's main() so we can tell which call SIGSEGVs on real
** Windows. Each call gets a stderr checkpoint via raw write(2,...)
** so output survives buffering and abnormal exits.
**
** shell.c does roughly:
**   setvbuf(stderr, 0, _IONBF, 0);
**   stdin_is_interactive = isatty(0);
**   stdout_is_console    = isatty(1);
**   atexit(sayAbnormalExit);
**
** plus reading from stdin via local_getline -> fgets. We probe
** each of those plus a couple of obvious follow-ons that shell.c
** does (process_input -> fgets via stdin pointer).
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

static void emit(char *s) {
    int n = (int)strlen(s);
    write(2, s, n);
}

static void on_exit_cb(void) {
    emit("[probe] atexit cb fired\n");
}

int main(int argc, char **argv) {
    int r0;
    int r1;
    int c;
    emit("[probe] main entered\n");

    emit("[probe] before setvbuf\n");
    setvbuf(stderr, 0, _IONBF, 0);
    emit("[probe] after  setvbuf\n");

    emit("[probe] before isatty(0)\n");
    r0 = isatty(0);
    emit("[probe] after  isatty(0)\n");

    emit("[probe] before isatty(1)\n");
    r1 = isatty(1);
    emit("[probe] after  isatty(1)\n");

    emit("[probe] before atexit\n");
    atexit(on_exit_cb);
    emit("[probe] after  atexit\n");

    emit("[probe] before fgetc(stdin)\n");
    c = fgetc(stdin);
    emit("[probe] after  fgetc(stdin)\n");

    emit("[probe] before fprintf\n");
    fprintf(stderr, "[probe] fprintf produced this line\n");
    fflush(stderr);
    emit("[probe] after  fprintf\n");

    emit("[probe] returning 0\n");
    return 0;
}
