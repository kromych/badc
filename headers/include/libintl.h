#pragma once

// Message translation (GNU gettext). The Linux C library provides these in libc; the
// returned pointer is the translated string, or the msgid itself when
// no catalog matches.

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::gettext,                 "gettext")
#pragma binding(libc::dgettext,                "dgettext")
#pragma binding(libc::dcgettext,               "dcgettext")
#pragma binding(libc::ngettext,                "ngettext")
#pragma binding(libc::dngettext,               "dngettext")
#pragma binding(libc::dcngettext,              "dcngettext")
#pragma binding(libc::textdomain,              "textdomain")
#pragma binding(libc::bindtextdomain,          "bindtextdomain")
#pragma binding(libc::bind_textdomain_codeset, "bind_textdomain_codeset")
#endif

char *gettext(const char *msgid);
char *dgettext(const char *domainname, const char *msgid);
char *dcgettext(const char *domainname, const char *msgid, int category);
char *ngettext(const char *msgid1, const char *msgid2, unsigned long n);
char *dngettext(const char *domainname, const char *msgid1,
                const char *msgid2, unsigned long n);
char *dcngettext(const char *domainname, const char *msgid1,
                 const char *msgid2, unsigned long n, int category);
char *textdomain(const char *domainname);
char *bindtextdomain(const char *domainname, const char *dirname);
char *bind_textdomain_codeset(const char *domainname, const char *codeset);
