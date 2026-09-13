/* The C99 and POSIX prototypes a program may repeat after the bundled
** headers: each declares the type the header gives the function (C99 6.7p4).
** Compiled for every target; the POSIX blocks are left out on Windows. */

#include <ctype.h>
#include <locale.h>
#include <math.h>
#include <setjmp.h>
#include <signal.h>
#include <stdarg.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <wchar.h>
#ifndef _WIN32
#include <fcntl.h>
#include <strings.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#endif

/* C99 7.1.4p1: a library function may also be defined as a macro. */
#undef atexit
#undef longjmp

/* C99 7.4 <ctype.h> */
int isalnum(int c);
int isalpha(int c);
int isblank(int c);
int iscntrl(int c);
int isdigit(int c);
int isgraph(int c);
int islower(int c);
int isprint(int c);
int ispunct(int c);
int isspace(int c);
int isupper(int c);
int isxdigit(int c);
int tolower(int c);
int toupper(int c);

/* C99 7.11 <locale.h>, 7.13 <setjmp.h>, 7.14 <signal.h> */
char *setlocale(int category, const char *locale);
struct lconv *localeconv(void);
void longjmp(jmp_buf env, int val);
int raise(int sig);
#ifndef _WIN32
int kill(pid_t pid, int sig);
#endif

/* C99 7.12 <math.h> */
double sqrt(double x);
double pow(double x, double y);
double floor(double x);
double ceil(double x);
double fabs(double x);
double fmod(double x, double y);
double ldexp(double x, int exp);
double frexp(double value, int *exp);
double modf(double value, double *iptr);
double exp(double x);
double log(double x);
double log10(double x);
double sin(double x);
double cos(double x);
double tan(double x);
double atan2(double y, double x);
double round(double x);
long int lround(double x);
double trunc(double x);
double copysign(double x, double y);
double nan(const char *tagp);
float sqrtf(float x);
float floorf(float x);
float fabsf(float x);
long double fabsl(long double x);
long double ldexpl(long double x, int exp);

/* C99 7.19 <stdio.h> */
int remove(const char *filename);
int rename(const char *old_name, const char *new_name);
FILE *tmpfile(void);
char *tmpnam(char *s);
int fclose(FILE *stream);
int fflush(FILE *stream);
FILE *fopen(const char *restrict filename, const char *restrict mode);
FILE *freopen(const char *restrict filename, const char *restrict mode, FILE *restrict stream);
void setbuf(FILE *restrict stream, char *restrict buf);
int setvbuf(FILE *restrict stream, char *restrict buf, int mode, size_t size);
int fprintf(FILE *restrict stream, const char *restrict format, ...);
int fscanf(FILE *restrict stream, const char *restrict format, ...);
int printf(const char *restrict format, ...);
int scanf(const char *restrict format, ...);
int snprintf(char *restrict s, size_t n, const char *restrict format, ...);
int sprintf(char *restrict s, const char *restrict format, ...);
int sscanf(const char *restrict s, const char *restrict format, ...);
int vfprintf(FILE *restrict stream, const char *restrict format, va_list arg);
int vfscanf(FILE *restrict stream, const char *restrict format, va_list arg);
int vprintf(const char *restrict format, va_list arg);
int vscanf(const char *restrict format, va_list arg);
int vsnprintf(char *restrict s, size_t n, const char *restrict format, va_list arg);
int vsprintf(char *restrict s, const char *restrict format, va_list arg);
int vsscanf(const char *restrict s, const char *restrict format, va_list arg);
int fgetc(FILE *stream);
char *fgets(char *restrict s, int n, FILE *restrict stream);
int fputc(int c, FILE *stream);
int fputs(const char *restrict s, FILE *restrict stream);
int getc(FILE *stream);
int getchar(void);
int putc(int c, FILE *stream);
int putchar(int c);
int puts(const char *s);
int ungetc(int c, FILE *stream);
size_t fread(void *restrict ptr, size_t size, size_t nmemb, FILE *restrict stream);
size_t fwrite(const void *restrict ptr, size_t size, size_t nmemb, FILE *restrict stream);
int fgetpos(FILE *restrict stream, fpos_t *restrict pos);
int fseek(FILE *stream, long int offset, int whence);
int fsetpos(FILE *stream, const fpos_t *pos);
long int ftell(FILE *stream);
void rewind(FILE *stream);
void clearerr(FILE *stream);
int feof(FILE *stream);
int ferror(FILE *stream);
void perror(const char *s);
#ifndef _WIN32
FILE *fdopen(int fildes, const char *mode);
int fileno(FILE *stream);
FILE *popen(const char *command, const char *mode);
int pclose(FILE *stream);
ssize_t getline(char **restrict lineptr, size_t *restrict n, FILE *restrict stream);
ssize_t getdelim(char **restrict lineptr, size_t *restrict n, int delimiter, FILE *restrict stream);
int fseeko(FILE *stream, off_t offset, int whence);
off_t ftello(FILE *stream);
int dprintf(int fildes, const char *restrict format, ...);
FILE *fmemopen(void *restrict buf, size_t size, const char *restrict mode);
FILE *open_memstream(char **bufp, size_t *sizep);
int getc_unlocked(FILE *stream);
int putc_unlocked(int c, FILE *stream);
void flockfile(FILE *file);
void funlockfile(FILE *file);
#endif

/* C99 7.20 <stdlib.h>; aligned_alloc is C11 7.22.3.1 */
double atof(const char *nptr);
int atoi(const char *nptr);
long int atol(const char *nptr);
long long int atoll(const char *nptr);
double strtod(const char *restrict nptr, char **restrict endptr);
float strtof(const char *restrict nptr, char **restrict endptr);
long double strtold(const char *restrict nptr, char **restrict endptr);
long int strtol(const char *restrict nptr, char **restrict endptr, int base);
long long int strtoll(const char *restrict nptr, char **restrict endptr, int base);
unsigned long int strtoul(const char *restrict nptr, char **restrict endptr, int base);
unsigned long long int strtoull(const char *restrict nptr, char **restrict endptr, int base);
int rand(void);
void srand(unsigned int seed);
void *calloc(size_t nmemb, size_t size);
void free(void *ptr);
void *malloc(size_t size);
void *realloc(void *ptr, size_t size);
void *aligned_alloc(size_t alignment, size_t size);
void abort(void);
int atexit(void (*func)(void));
void exit(int status);
void _Exit(int status);
char *getenv(const char *name);
int system(const char *string);
void *bsearch(const void *key, const void *base, size_t nmemb, size_t size,
              int (*compar)(const void *, const void *));
void qsort(void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *));
int abs(int j);
long int labs(long int j);
long long int llabs(long long int j);
div_t div(int numer, int denom);
ldiv_t ldiv(long int numer, long int denom);
lldiv_t lldiv(long long int numer, long long int denom);
int mblen(const char *s, size_t n);
int mbtowc(wchar_t *restrict pwc, const char *restrict s, size_t n);
int wctomb(char *s, wchar_t wc);
size_t mbstowcs(wchar_t *restrict pwcs, const char *restrict s, size_t n);
size_t wcstombs(char *restrict s, const wchar_t *restrict pwcs, size_t n);
#ifndef _WIN32
int setenv(const char *envname, const char *envval, int overwrite);
int unsetenv(const char *name);
int putenv(char *string);
char *realpath(const char *restrict file_name, char *restrict resolved_name);
int mkstemp(char *templ);
char *mkdtemp(char *templ);
int posix_memalign(void **memptr, size_t alignment, size_t size);
long random(void);
void srandom(unsigned seed);
int rand_r(unsigned *seed);
double drand48(void);
#endif

/* C99 7.21 <string.h> */
void *memcpy(void *restrict s1, const void *restrict s2, size_t n);
void *memmove(void *s1, const void *s2, size_t n);
char *strcpy(char *restrict s1, const char *restrict s2);
char *strncpy(char *restrict s1, const char *restrict s2, size_t n);
char *strcat(char *restrict s1, const char *restrict s2);
char *strncat(char *restrict s1, const char *restrict s2, size_t n);
int memcmp(const void *s1, const void *s2, size_t n);
int strcmp(const char *s1, const char *s2);
int strcoll(const char *s1, const char *s2);
int strncmp(const char *s1, const char *s2, size_t n);
size_t strxfrm(char *restrict s1, const char *restrict s2, size_t n);
void *memchr(const void *s, int c, size_t n);
char *strchr(const char *s, int c);
size_t strcspn(const char *s1, const char *s2);
char *strpbrk(const char *s1, const char *s2);
char *strrchr(const char *s, int c);
size_t strspn(const char *s1, const char *s2);
char *strstr(const char *s1, const char *s2);
char *strtok(char *restrict s1, const char *restrict s2);
void *memset(void *s, int c, size_t n);
char *strerror(int errnum);
size_t strlen(const char *s);
/* glibc declares mempcpy only under _GNU_SOURCE, so a program may define it. */
static void *mempcpy(void *dst, const void *src, size_t n) {
    return (char *)memcpy(dst, src, n) + n;
}
#ifndef _WIN32
char *strdup(const char *s);
char *strndup(const char *s, size_t size);
char *strtok_r(char *restrict s, const char *restrict sep, char **restrict state);
char *stpcpy(char *restrict s1, const char *restrict s2);
char *stpncpy(char *restrict s1, const char *restrict s2, size_t size);
size_t strnlen(const char *s, size_t maxlen);
void *memccpy(void *restrict s1, const void *restrict s2, int c, size_t n);
char *strsignal(int signum);
int strcasecmp(const char *s1, const char *s2);
int strncasecmp(const char *s1, const char *s2, size_t n);
#endif

/* C99 7.23 <time.h> */
clock_t clock(void);
double difftime(time_t time1, time_t time0);
time_t mktime(struct tm *timeptr);
time_t time(time_t *timer);
char *asctime(const struct tm *timeptr);
char *ctime(const time_t *timer);
struct tm *gmtime(const time_t *timer);
struct tm *localtime(const time_t *timer);
size_t strftime(char *restrict s, size_t maxsize, const char *restrict format,
                const struct tm *restrict timeptr);
#ifndef _WIN32
struct tm *localtime_r(const time_t *restrict timer, struct tm *restrict result);
struct tm *gmtime_r(const time_t *restrict timer, struct tm *restrict result);
int clock_gettime(clockid_t clock_id, struct timespec *tp);
int nanosleep(const struct timespec *rqtp, struct timespec *rmtp);
#endif

/* C99 7.24 <wchar.h> */
size_t wcslen(const wchar_t *s);
int wcscmp(const wchar_t *s1, const wchar_t *s2);
int wcsncmp(const wchar_t *s1, const wchar_t *s2, size_t n);
wchar_t *wcschr(const wchar_t *s, wchar_t c);
wchar_t *wcsrchr(const wchar_t *s, wchar_t c);
wchar_t *wcsstr(const wchar_t *s1, const wchar_t *s2);
wchar_t *wcscpy(wchar_t *restrict s1, const wchar_t *restrict s2);
wchar_t *wcsncpy(wchar_t *restrict s1, const wchar_t *restrict s2, size_t n);
wchar_t *wcscat(wchar_t *restrict s1, const wchar_t *restrict s2);
wchar_t *wcsncat(wchar_t *restrict s1, const wchar_t *restrict s2, size_t n);
size_t wcsspn(const wchar_t *s1, const wchar_t *s2);
size_t wcscspn(const wchar_t *s1, const wchar_t *s2);
wchar_t *wcspbrk(const wchar_t *s1, const wchar_t *s2);
wchar_t *wmemcpy(wchar_t *restrict s1, const wchar_t *restrict s2, size_t n);
wchar_t *wmemmove(wchar_t *s1, const wchar_t *s2, size_t n);
wchar_t *wmemset(wchar_t *s, wchar_t c, size_t n);
int wmemcmp(const wchar_t *s1, const wchar_t *s2, size_t n);
wchar_t *wmemchr(const wchar_t *s, wchar_t c, size_t n);
wint_t fgetwc(FILE *stream);
wchar_t *fgetws(wchar_t *restrict s, int n, FILE *restrict stream);
wint_t fputwc(wchar_t c, FILE *stream);
int fputws(const wchar_t *restrict s, FILE *restrict stream);
size_t mbrtowc(wchar_t *restrict pwc, const char *restrict s, size_t n, mbstate_t *restrict ps);
size_t wcrtomb(char *restrict s, wchar_t wc, mbstate_t *restrict ps);
long int wcstol(const wchar_t *restrict nptr, wchar_t **restrict endptr, int base);
double wcstod(const wchar_t *restrict nptr, wchar_t **restrict endptr);
int swprintf(wchar_t *restrict s, size_t n, const wchar_t *restrict format, ...);
int wprintf(const wchar_t *restrict format, ...);
int fwprintf(FILE *restrict stream, const wchar_t *restrict format, ...);

/* POSIX <fcntl.h>, <sys/stat.h>, <unistd.h> */
#ifndef _WIN32
int open(const char *path, int oflag, ...);
int stat(const char *restrict path, struct stat *restrict buf);
int lstat(const char *restrict path, struct stat *restrict buf);
int fstat(int fildes, struct stat *buf);
int access(const char *path, int amode);
int chdir(const char *path);
int close(int fildes);
int dup(int fildes);
int dup2(int fildes, int fildes2);
int execv(const char *path, char *const argv[]);
int execvp(const char *file, char *const argv[]);
int execve(const char *path, char *const argv[], char *const envp[]);
pid_t fork(void);
char *getcwd(char *buf, size_t size);
pid_t getpid(void);
pid_t getppid(void);
uid_t getuid(void);
int isatty(int fildes);
int link(const char *path1, const char *path2);
off_t lseek(int fildes, off_t offset, int whence);
int pipe(int fildes[2]);
ssize_t read(int fildes, void *buf, size_t nbyte);
ssize_t readlink(const char *restrict path, char *restrict buf, size_t bufsize);
int rmdir(const char *path);
unsigned sleep(unsigned seconds);
int symlink(const char *path1, const char *path2);
long sysconf(int name);
int unlink(const char *path);
ssize_t write(int fildes, const void *buf, size_t nbyte);
int ftruncate(int fildes, off_t length);
int fsync(int fildes);
int gethostname(char *name, size_t namelen);
pid_t setsid(void);
int getopt(int argc, char *const argv[], const char *optstring);
extern char *optarg;
extern int optind, opterr, optopt;
#endif
