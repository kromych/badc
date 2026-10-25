// ucrtbase.dll's locale for msvcrt.dll's LC_NUMERIC, one per name, kept for
// the process, on Windows; elsewhere the file is empty and the link offers
// it like an archive member.

#ifdef _WIN32

#include <locale.h>
#include <stdlib.h>
#include <string.h>

#pragma dylib(ucrtbase, "ucrtbase.dll")
#pragma binding(ucrtbase::__c5_ucrt_create_locale, "_create_locale")
void *__c5_ucrt_create_locale(int category, const char *locale);

struct numeric {
    struct numeric *next;
    void *locale;
    char name[];
};

static void *numeric_locale(const char *name) {
    static struct numeric *known;
    struct numeric *head = __atomic_load_n(&known, __ATOMIC_ACQUIRE);
    for (struct numeric *e = head; e; e = e->next)
        if (!strcmp(e->name, name))
            return e->locale;
    size_t len = strlen(name) + 1;
    struct numeric *e = malloc(sizeof *e + len);
    if (!e)
        return NULL;
    memcpy(e->name, name, len);
    e->locale = __c5_ucrt_create_locale(LC_NUMERIC, name);
    e->next = head;
    while (!__atomic_compare_exchange_n(&known, &e->next, e, 0, __ATOMIC_ACQ_REL,
                                        __ATOMIC_ACQUIRE))
        ;
    return e->locale;
}

void *__c5_ucrt_numeric_locale(void) {
    if (*localeconv()->decimal_point == '.')
        return numeric_locale("C");
    return numeric_locale(setlocale(LC_NUMERIC, NULL));
}

#endif
