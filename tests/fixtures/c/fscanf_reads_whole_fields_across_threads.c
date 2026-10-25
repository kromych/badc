// POSIX.1-2008 2.5 and C11 7.21.2p8: a stream function holds the stream's
// lock for the whole call, so fscanf and fwscanf from two threads sharing a
// stream each read a whole field. Every number read is one that was written,
// and together the threads read each once; with twenty streams open first,
// the shared one is past any table of streams the library keeps.
// snapshot-budget: exempt

#include <pthread.h>
#include <stdio.h>
#include <wchar.h>

#define COUNT 4000
#define FIRST 100000L

static FILE *shared;
static int wide;
static long sum[2], bad[2];

static void *reader(void *arg) {
    long k = (long)arg, v;
    while (wide ? fwscanf(shared, L"%ld", &v) == 1 : fscanf(shared, "%ld", &v) == 1) {
        bad[k] += v < FIRST || v >= FIRST + COUNT;
        sum[k] += v;
    }
    return NULL;
}

static int race(int w) {
    pthread_t t[2];
    wide = w;
    sum[0] = sum[1] = bad[0] = bad[1] = 0;
    if (!(shared = tmpfile()))
        return 1;
    for (long i = 0; i < COUNT; ++i)
        if ((w ? fwprintf(shared, L"%ld ", FIRST + i) : fprintf(shared, "%ld ", FIRST + i)) < 0)
            return 2;
    rewind(shared);
    for (long k = 0; k < 2; ++k)
        if (pthread_create(&t[k], NULL, reader, (void *)k))
            return 3;
    for (int k = 0; k < 2; ++k)
        pthread_join(t[k], NULL);
    fclose(shared);
    long want = COUNT * FIRST + (long)COUNT * (COUNT - 1) / 2;
    return bad[0] || bad[1] || sum[0] + sum[1] != want ? 4 : 0;
}

int main(void) {
    FILE *open[20];
    int r;
    if ((r = race(0)))
        return r;
    for (int i = 0; i < 20; ++i)
        if (!(open[i] = tmpfile()))
            return 5;
    if ((r = race(0)) || (r = race(1)))
        return 10 + r;
    for (int i = 0; i < 20; ++i)
        fclose(open[i]);
    return 0;
}
