#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <dlfcn.h>

// Async "Hello, World!" HTTP server.
//
// Reaches POSIX sockets through dlopen/dlsym -- badc doesn't ship a
// <sys/socket.h>, but the symbols live in libc and are visible
// through the global handle (`dlopen(NULL, RTLD_NOW)`).
//
// The "async" part is event-driven, not threaded: a single select()
// loop multiplexes the listener and up to MAX_CLIENTS in-flight
// client sockets. New connections are accepted into a free slot and
// the response is fanned out as each slot becomes writable. The
// loop never blocks on a single fd, so a slow client can't stall
// the others.
//
// Linux x86_64 and Linux aarch64. The sockaddr_in layout below is
// the Linux flavour (no leading sin_len byte). Build and run:
//
//   cargo run -- --emit-native --target=linux-x64 -O \
//       -o hello demos/hello_server.c
//   ./hello                      # listens on 0.0.0.0:8080
//   curl http://localhost:8080/  # -> Hello, World!
//
// Note on the c4 dialect: badc is a c4 derivative, so the source
// here pays for that with parallel int arrays (no struct array
// index, no struct-member function calls), free-standing globals
// for libc symbols, and manual byte writes into the sockaddr_in /
// fd_set buffers (no <sys/socket.h>, no FD_SET macro).

// htons(8080): high byte 0x1F, low byte 0x90.
#define PORT_HI       0x1F
#define PORT_LO       0x90
#define AF_INET       2
#define SOCK_STREAM   1
#define SOL_SOCKET    1
#define SO_REUSEADDR  2
#define BACKLOG       16
#define MAX_CLIENTS   8
// FD_SETSIZE/8 on Linux.
#define FD_SET_BYTES  128
// fcntl op for "set fd flags" + the non-blocking bit.
#define F_SETFL       4
#define O_NONBLOCK    04000

// Per-slot state machine: free -> reading -> writing -> free.
#define SLOT_FREE     0
#define SLOT_READING  1
#define SLOT_WRITING  2

// libc function pointers, populated in main() via dlsym. Globals
// because the c4 dialect doesn't allow calling a struct member as
// a function (`p->fn(...)`) -- only direct identifier calls work.
int *g_socket;
int *g_setsockopt;
int *g_bind;
int *g_listen;
int *g_accept;
int *g_select;
int *g_read;
int *g_write;
int *g_close;
int *g_fcntl;

// Per-slot state. Parallel int arrays keep indexing simple --
// `slot_fd[i]` is just `*(slot_fd + i)`, while `slots[i].fd` would
// need manual sizeof-struct stride that the c4 dialect doesn't do
// automatically.
int *slot_fd;
int *slot_state;
int *slot_written;

void fdset_zero(char *fds) {
    memset(fds, 0, FD_SET_BYTES);
}

// FD_SET / FD_ISSET as raw byte ops -- Linux fd_set is just a
// little-endian bitmap of FD_SETSIZE bits.
void fdset_set(char *fds, int fd) {
    int byte_off;
    int bit;
    byte_off = fd / 8;
    bit = fd & 7;
    *(fds + byte_off) = *(fds + byte_off) | (1 << bit);
}

int fdset_isset(char *fds, int fd) {
    int byte_off;
    int bit;
    byte_off = fd / 8;
    bit = fd & 7;
    return (*(fds + byte_off) >> bit) & 1;
}

int build_listener() {
    int fd;
    char *addr;
    int *one;
    int rc;

    fd = g_socket(AF_INET, SOCK_STREAM, 0);
    if (fd < 0) return -1;

    // SO_REUSEADDR so a quick restart doesn't trip TIME_WAIT.
    one = malloc(sizeof(int));
    *one = 1;
    g_setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, one, sizeof(int));
    free(one);

    // sockaddr_in (Linux, 16 bytes):
    //   [0..1]  sin_family  = AF_INET (LE u16)
    //   [2..3]  sin_port    = 8080    (BE u16)
    //   [4..7]  sin_addr    = 0.0.0.0 (BE u32)
    //   [8..15] sin_zero[8] = 0
    addr = malloc(16);
    memset(addr, 0, 16);
    *(addr + 0) = AF_INET;
    *(addr + 2) = PORT_HI;
    *(addr + 3) = PORT_LO;

    rc = g_bind(fd, addr, 16);
    free(addr);
    if (rc < 0) { g_close(fd); return -1; }

    rc = g_listen(fd, BACKLOG);
    if (rc < 0) { g_close(fd); return -1; }

    // O_NONBLOCK on the listener so accept doesn't block when
    // select returns spuriously.
    g_fcntl(fd, F_SETFL, O_NONBLOCK);
    return fd;
}

int find_free_slot() {
    int i;
    i = 0;
    while (i < MAX_CLIENTS) {
        if (slot_state[i] == SLOT_FREE) return i;
        i = i + 1;
    }
    return -1;
}

void close_slot(int i) {
    g_close(slot_fd[i]);
    slot_fd[i] = -1;
    slot_state[i] = SLOT_FREE;
    slot_written[i] = 0;
}

int main() {
    int *handle;
    int listener;
    char *rfds;
    char *wfds;
    int i;
    int nfds;
    int rc;
    char *response;
    int response_len;
    char *scratch;
    int client;
    int idx;
    int n;

    handle = dlopen(0, 2);                 // RTLD_NOW
    if (handle == 0) { printf("dlopen failed\n"); return 1; }

    g_socket     = dlsym(handle, "socket");
    g_setsockopt = dlsym(handle, "setsockopt");
    g_bind       = dlsym(handle, "bind");
    g_listen     = dlsym(handle, "listen");
    g_accept     = dlsym(handle, "accept");
    g_select     = dlsym(handle, "select");
    g_read       = dlsym(handle, "read");
    g_write      = dlsym(handle, "write");
    g_close      = dlsym(handle, "close");
    g_fcntl      = dlsym(handle, "fcntl");

    listener = build_listener();
    if (listener < 0) { printf("listen on :8080 failed\n"); return 2; }

    response = "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\nContent-Length: 13\r\nConnection: close\r\n\r\nHello, World!";
    response_len = strlen(response);

    slot_fd      = malloc(sizeof(int) * MAX_CLIENTS);
    slot_state   = malloc(sizeof(int) * MAX_CLIENTS);
    slot_written = malloc(sizeof(int) * MAX_CLIENTS);
    i = 0;
    while (i < MAX_CLIENTS) {
        slot_fd[i] = -1;
        slot_state[i] = SLOT_FREE;
        slot_written[i] = 0;
        i = i + 1;
    }

    rfds = malloc(FD_SET_BYTES);
    wfds = malloc(FD_SET_BYTES);
    scratch = malloc(1024);

    printf("hello_server: listening on 0.0.0.0:8080 (Ctrl-C to quit)\n");

    while (1) {
        fdset_zero(rfds);
        fdset_zero(wfds);
        fdset_set(rfds, listener);
        nfds = listener;

        i = 0;
        while (i < MAX_CLIENTS) {
            if (slot_state[i] == SLOT_READING) {
                fdset_set(rfds, slot_fd[i]);
                if (slot_fd[i] > nfds) nfds = slot_fd[i];
            } else if (slot_state[i] == SLOT_WRITING) {
                fdset_set(wfds, slot_fd[i]);
                if (slot_fd[i] > nfds) nfds = slot_fd[i];
            }
            i = i + 1;
        }

        rc = g_select(nfds + 1, rfds, wfds, 0, 0);
        if (rc < 0) break;

        if (fdset_isset(rfds, listener)) {
            client = g_accept(listener, 0, 0);
            if (client >= 0) {
                idx = find_free_slot();
                if (idx < 0) {
                    g_close(client);            // no room -- drop
                } else {
                    g_fcntl(client, F_SETFL, O_NONBLOCK);
                    slot_fd[idx] = client;
                    slot_state[idx] = SLOT_READING;
                    slot_written[idx] = 0;
                }
            }
        }

        i = 0;
        while (i < MAX_CLIENTS) {
            if (slot_state[i] == SLOT_READING && fdset_isset(rfds, slot_fd[i])) {
                // Drain the request line + headers; we don't
                // parse anything, just consume up to 1KiB and
                // flip to writing.
                n = g_read(slot_fd[i], scratch, 1024);
                if (n <= 0) {
                    close_slot(i);
                } else {
                    slot_state[i] = SLOT_WRITING;
                }
            } else if (slot_state[i] == SLOT_WRITING && fdset_isset(wfds, slot_fd[i])) {
                n = g_write(slot_fd[i],
                            response + slot_written[i],
                            response_len - slot_written[i]);
                if (n <= 0) {
                    close_slot(i);
                } else {
                    slot_written[i] = slot_written[i] + n;
                    if (slot_written[i] >= response_len) close_slot(i);
                }
            }
            i = i + 1;
        }
    }

    g_close(listener);
    free(slot_fd);
    free(slot_state);
    free(slot_written);
    free(rfds);
    free(wfds);
    free(scratch);
    return 0;
}
