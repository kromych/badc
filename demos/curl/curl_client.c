/* curl_client.c -- exercises libcurl's public API end to end.
 *
 * Runs against any libcurl the smoke links it to: the badc-built static or
 * dynamic library, or the system libcurl (via the -include binding header).
 * The scenarios are offline unless a base URL is passed on argv: version and
 * feature reporting, the URL API, escape round-tripping, the string list, and
 * a file:// transfer through the easy handle. When argv[1] is an http(s):// or
 * file:// base URL the client additionally fetches "<base>/hello" and checks
 * the body, which the smoke uses to drive a hermetic loopback server.
 */

#include <curl/curl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>   /* getcwd (mapped to _getcwd on Windows) */

struct membuf {
    char *data;
    size_t len;
};

static size_t collect(char *ptr, size_t size, size_t nmemb, void *userp)
{
    size_t n = size * nmemb;
    struct membuf *m = (struct membuf *)userp;
    char *grown = (char *)realloc(m->data, m->len + n + 1);
    if(!grown)
        return 0;
    m->data = grown;
    memcpy(m->data + m->len, ptr, n);
    m->len += n;
    m->data[m->len] = '\0';
    return n;
}

static int fail(const char *what)
{
    fprintf(stderr, "curl smoke FAIL: %s\n", what);
    return 1;
}

static int scenario_version(void)
{
    const char *v = curl_version();
    if(!v || !strstr(v, "libcurl/"))
        return fail("curl_version missing libcurl/ prefix");
    printf("version OK: %s\n", v);

    curl_version_info_data *vi = curl_version_info(CURLVERSION_NOW);
    if(!vi)
        return fail("curl_version_info returned NULL");
    printf("version_info OK: num=0x%06x ssl=%s\n", vi->version_num,
           (vi->features & CURL_VERSION_SSL) ? "yes" : "no");
    return 0;
}

static int scenario_url(void)
{
    CURLU *u = curl_url();
    if(!u)
        return fail("curl_url alloc");
    /* CURLU_NON_SUPPORT_SCHEME so the structural parse succeeds whether or
       not https is a compiled-in protocol (HTTP-only vs BearSSL builds). */
    if(curl_url_set(u, CURLUPART_URL,
                    "https://bob@example.com:8443/dir/file?q=1&r=2",
                    CURLU_NON_SUPPORT_SCHEME)) {
        curl_url_cleanup(u);
        return fail("curl_url_set");
    }
    char *host = NULL, *port = NULL, *path = NULL, *query = NULL, *user = NULL;
    int bad = curl_url_get(u, CURLUPART_HOST, &host, 0)
              || curl_url_get(u, CURLUPART_PORT, &port, 0)
              || curl_url_get(u, CURLUPART_PATH, &path, 0)
              || curl_url_get(u, CURLUPART_QUERY, &query, 0)
              || curl_url_get(u, CURLUPART_USER, &user, 0);
    int ok = !bad && !strcmp(host, "example.com") && !strcmp(port, "8443")
             && !strcmp(path, "/dir/file") && !strcmp(query, "q=1&r=2")
             && !strcmp(user, "bob");
    printf("url OK: host=%s port=%s path=%s query=%s user=%s\n",
           host, port, path, query, user);
    curl_free(host);
    curl_free(port);
    curl_free(path);
    curl_free(query);
    curl_free(user);
    curl_url_cleanup(u);
    return ok ? 0 : fail("url parts mismatch");
}

static int scenario_escape(void)
{
    CURL *e = curl_easy_init();
    if(!e)
        return fail("curl_easy_init for escape");
    const char *raw = "a b/c?d=e&f";
    char *enc = curl_easy_escape(e, raw, 0);
    int outlen = 0;
    char *dec = enc ? curl_easy_unescape(e, enc, 0, &outlen) : NULL;
    int ok = enc && dec && !strcmp(dec, raw) && !strchr(enc, ' ');
    printf("escape OK: '%s' -> '%s' -> '%s'\n", raw, enc ? enc : "(null)",
           dec ? dec : "(null)");
    curl_free(enc);
    curl_free(dec);
    curl_easy_cleanup(e);
    return ok ? 0 : fail("escape round-trip");
}

static int scenario_slist(void)
{
    struct curl_slist *h = NULL;
    h = curl_slist_append(h, "X-One: 1");
    h = curl_slist_append(h, "X-Two: 2");
    int n = 0;
    for(struct curl_slist *p = h; p; p = p->next)
        n++;
    curl_slist_free_all(h);
    printf("slist OK: %d entries\n", n);
    return n == 2 ? 0 : fail("slist count");
}

static int transfer(const char *url, const char *want)
{
    CURL *e = curl_easy_init();
    if(!e)
        return fail("curl_easy_init for transfer");
    struct membuf body = {NULL, 0};
    curl_easy_setopt(e, CURLOPT_URL, url);
    curl_easy_setopt(e, CURLOPT_WRITEFUNCTION, collect);
    curl_easy_setopt(e, CURLOPT_WRITEDATA, &body);
    curl_easy_setopt(e, CURLOPT_TIMEOUT, 10L);
    /* Loopback TLS uses a throwaway self-signed cert, so peer/host
       verification is turned off for the hermetic test. */
    curl_easy_setopt(e, CURLOPT_SSL_VERIFYPEER, 0L);
    curl_easy_setopt(e, CURLOPT_SSL_VERIFYHOST, 0L);
    CURLcode rc = curl_easy_perform(e);
    int ok = (rc == CURLE_OK) && body.data && strstr(body.data, want);
    if(rc != CURLE_OK)
        fprintf(stderr, "  transfer %s: %s\n", url, curl_easy_strerror(rc));
    else
        printf("transfer OK: %s -> %zu bytes\n", url, body.len);
    free(body.data);
    curl_easy_cleanup(e);
    return ok ? 0 : fail("transfer");
}

static int scenario_file(void)
{
    /* Write a temp file and read it back through file://. */
    const char *path = "curl_smoke_file.txt";
    const char *content = "badc-file-scheme-payload";
    FILE *f = fopen(path, "wb");
    if(!f)
        return fail("temp file create");
    fwrite(content, 1, strlen(content), f);
    fclose(f);
    char url[512];
    char cwd[400];
    if(!getcwd(cwd, sizeof cwd))
        return fail("getcwd");
#ifdef _WIN32
    /* file:///C:/dir/file -- forward slashes and the extra leading slash for
       the drive-letter path. */
    for(char *p = cwd; *p; p++)
        if(*p == '\\')
            *p = '/';
    snprintf(url, sizeof url, "file:///%s/%s", cwd, path);
#else
    snprintf(url, sizeof url, "file://%s/%s", cwd, path);
#endif
    int rc = transfer(url, content);
    remove(path);
    return rc;
}

int main(int argc, char **argv)
{
    setvbuf(stdout, NULL, _IOLBF, 0);
    if(curl_global_init(CURL_GLOBAL_DEFAULT) != CURLE_OK)
        return fail("curl_global_init");

    int rc = 0;
    rc |= scenario_version();
    rc |= scenario_url();
    rc |= scenario_escape();
    rc |= scenario_slist();
    rc |= scenario_file();

    /* Optional networked fetch against a base URL supplied by the smoke. */
    if(argc > 1 && argv[1][0]) {
        char url[512];
        snprintf(url, sizeof url, "%s/hello", argv[1]);
        rc |= transfer(url, "hello-from-loopback");
    }

    curl_global_cleanup();
    if(rc == 0)
        printf("curl smoke: all scenarios green\n");
    return rc;
}
