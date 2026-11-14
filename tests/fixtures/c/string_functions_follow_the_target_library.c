// C99 7.21 and 7.4: copying, concatenation, comparison, search and
// tokenizing, and character classification in the "C" locale. What a
// comparison and a classification return beyond their sign or truth is the
// C library's: glibc's and Apple's strcmp the byte difference, msvcrt's -1
// or 1; glibc's isalpha its table bit, Apple's 1, msvcrt's its mask.

// snapshot-budget: exempt
#define _GNU_SOURCE
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>

int main(void) {
    char buf[64], a[] = "a", c[] = "c", *p, *save;
    strcpy(buf, "hello");
    strcat(buf, ", world");
    strncat(buf, "!!!", 1);
    printf("%d [%s] %d %d %d %d\n", (int)strlen(buf), buf, strcmp(a, c), strncmp("abc", "abd", 2),
           strcasecmp("ABC", "abd") < 0, (int)strnlen(buf, 4));
    printf("[%s] [%s] [%s] %d %d [%s]\n", strchr(buf, 'o'), strrchr(buf, 'o'), strstr(buf, "wor"),
           (int)strspn("aabbc", "ab"), (int)strcspn("hello", "l"), strpbrk(buf, ",!"));
    printf("%d %d %d\n", strchr(buf, 'z') == 0, strchr(buf, 0) == buf + 13, strstr(buf, "") == buf);
    char *d = strdup(buf), *e = strndup(buf, 4);
    d[0] = 'H';
    printf("[%s] [%s] [%s]\n", d, buf, e);
    free(d);
    free(e);
    char line[] = "  a,b;;c  ";
    for (p = strtok(line, " ,;"); p; p = strtok(0, " ,;"))
        printf("<%s>", p);
    char pairs[] = "x=1&y=2";
    for (p = strtok_r(pairs, "&", &save); p; p = strtok_r(0, "&", &save))
        printf("{%s}", p);
    char n[8] = "zzzzzzz";
    strncpy(n, "ab", 5);
    printf(" %d%d%d%c %s\n", n[2], n[3], n[4], n[5], n);
    const char *m = memchr("abcdef", 'd', 6);
    printf("%s %d %s\n", m, memcmp("ab", "ac", 2) < 0, (char *)memrchr("abcabc", 'b', 6));
    printf("%d %d %d %d %c%c %d %d|", isalpha('a') != 0, isdigit('x') != 0, isspace('\n') != 0,
           ispunct('!') != 0, toupper('q'), tolower('Q'), toupper(-1), isalpha(0xe9));
    printf("%d %d %d\n", isalpha('a'), isdigit('5'), isspace(' '));
    return 0;
}
