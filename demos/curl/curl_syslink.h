/* curl_syslink.h -- bind the demo client to the platform's installed libcurl.
 *
 * badc's -l resolves only to a static archive, so a dynamic dependency on a
 * system shared library is expressed in source: `#pragma dylib` names the
 * library (install name / soname / DLL name) and each `#pragma binding` maps a
 * called symbol to its exported name. badc turns these into LC_LOAD_DYLIB
 * (Mach-O), DT_NEEDED (ELF), or a PE import descriptor, and the loader resolves
 * them at run time -- proving a badc-compiled client is ABI-compatible with the
 * OS libcurl. Force-include this header (-include) ahead of the client.
 *
 * Only the symbols the client actually calls are listed. macOS Mach-O prefixes
 * exported symbols with an underscore; ELF and PE use the bare C name. Windows
 * ships no redistributable libcurl, so the smoke skips this flavour there.
 */

#ifndef BADC_CURL_SYSLINK_H
#define BADC_CURL_SYSLINK_H

#if defined(__APPLE__)
#pragma dylib(libcurl, "/usr/lib/libcurl.4.dylib")
#pragma binding(libcurl::curl_global_init,   "_curl_global_init")
#pragma binding(libcurl::curl_global_cleanup, "_curl_global_cleanup")
#pragma binding(libcurl::curl_version,       "_curl_version")
#pragma binding(libcurl::curl_version_info,  "_curl_version_info")
#pragma binding(libcurl::curl_free,          "_curl_free")
#pragma binding(libcurl::curl_url,           "_curl_url")
#pragma binding(libcurl::curl_url_set,       "_curl_url_set")
#pragma binding(libcurl::curl_url_get,       "_curl_url_get")
#pragma binding(libcurl::curl_url_cleanup,   "_curl_url_cleanup")
#pragma binding(libcurl::curl_easy_init,     "_curl_easy_init")
#pragma binding(libcurl::curl_easy_cleanup,  "_curl_easy_cleanup")
#pragma binding(libcurl::curl_easy_setopt,   "_curl_easy_setopt")
#pragma binding(libcurl::curl_easy_perform,  "_curl_easy_perform")
#pragma binding(libcurl::curl_easy_strerror, "_curl_easy_strerror")
#pragma binding(libcurl::curl_easy_escape,   "_curl_easy_escape")
#pragma binding(libcurl::curl_easy_unescape, "_curl_easy_unescape")
#pragma binding(libcurl::curl_slist_append,  "_curl_slist_append")
#pragma binding(libcurl::curl_slist_free_all, "_curl_slist_free_all")

#elif defined(__linux__)
#pragma dylib(libcurl, "libcurl.so.4")
#pragma binding(libcurl::curl_global_init,   "curl_global_init")
#pragma binding(libcurl::curl_global_cleanup, "curl_global_cleanup")
#pragma binding(libcurl::curl_version,       "curl_version")
#pragma binding(libcurl::curl_version_info,  "curl_version_info")
#pragma binding(libcurl::curl_free,          "curl_free")
#pragma binding(libcurl::curl_url,           "curl_url")
#pragma binding(libcurl::curl_url_set,       "curl_url_set")
#pragma binding(libcurl::curl_url_get,       "curl_url_get")
#pragma binding(libcurl::curl_url_cleanup,   "curl_url_cleanup")
#pragma binding(libcurl::curl_easy_init,     "curl_easy_init")
#pragma binding(libcurl::curl_easy_cleanup,  "curl_easy_cleanup")
#pragma binding(libcurl::curl_easy_setopt,   "curl_easy_setopt")
#pragma binding(libcurl::curl_easy_perform,  "curl_easy_perform")
#pragma binding(libcurl::curl_easy_strerror, "curl_easy_strerror")
#pragma binding(libcurl::curl_easy_escape,   "curl_easy_escape")
#pragma binding(libcurl::curl_easy_unescape, "curl_easy_unescape")
#pragma binding(libcurl::curl_slist_append,  "curl_slist_append")
#pragma binding(libcurl::curl_slist_free_all, "curl_slist_free_all")
#endif

#endif /* BADC_CURL_SYSLINK_H */
