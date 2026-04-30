#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/select.h>
#include <fcntl.h>

#ifdef _WIN32
#include <windows.h>
#endif

// Async "Hello, World!" HTTP server.
//
// One select() loop multiplexes the listener and up to MAX_CLIENTS
// in-flight client sockets. New connections are accepted into a
// free slot and the response is fanned out as each slot becomes
// writable. The loop never blocks on a single fd, so a slow client
// can't stall the others.
//
// Cross-platform on macOS, Linux, and Windows. Build/run:
//
//   cargo run -- --emit-native -O -o hello demos/hello_server.c
//   ./hello                           # listens on 0.0.0.0:8080
//   curl http://localhost:8080/       # -> Hello, World!
//
// The byte-level constants (AF_INET, SOL_SOCKET, ...) and the
// libc / Winsock symbol bindings come from <sys/socket.h>; the
// dialect-driven choices that don't fit in a header (the macOS
// sin_len byte, the close vs closesocket spelling, the fcntl vs
// ioctlsocket non-blocking dance) sit behind the few #ifdefs
// below.

// htons(8080): high byte 0x1F, low byte 0x90.
#define PORT_HI       0x1F
#define PORT_LO       0x90
#define BACKLOG       16
#define MAX_CLIENTS   8

#define SLOT_FREE     0
#define SLOT_READING  1
#define SLOT_WRITING  2

// Per-slot parallel int arrays. badc's c5 dialect doesn't auto-
// stride struct array indexes by sizeof(struct), so flat int
// arrays are the cheapest way to keep `slots[i].field` ergonomics.
int *slot_fd;
int *slot_state;
int *slot_written;

void fdset_zero(char *fds) {
    memset(fds, 0, FD_SET_BYTES);
}

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

// Cross-platform "close this socket fd" wrapper.
void sock_close(int fd) {
#ifdef _WIN32
    closesocket(fd);
#else
    close(fd);
#endif
}

// Cross-platform "set this fd non-blocking".
void sock_nonblock(int fd) {
#ifdef _WIN32
    int *one;
    one = malloc(sizeof(int));
    *one = 1;
    ioctlsocket(fd, FIONBIO, one);
    free(one);
#else
    fcntl(fd, F_SETFL, O_NONBLOCK);
#endif
}

int build_listener() {
    int fd;
    char *addr;
    int *one;
    int rc;

    fd = socket(AF_INET, SOCK_STREAM, 0);
    if (fd < 0) return -1;

    one = malloc(sizeof(int));
    *one = 1;
    setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, (char *)one, sizeof(int));
    free(one);

    // sockaddr_in: 16 bytes, layout drift between macOS and the rest
    // is just the leading sin_len byte (macOS only). Everything else
    // (sin_port at offset 2, sin_addr at offset 4) lines up.
    addr = malloc(SOCKADDR_IN_SIZE);
    memset(addr, 0, SOCKADDR_IN_SIZE);
#ifdef __APPLE__
    *(addr + 0) = SOCKADDR_IN_SIZE;     // sin_len
    *(addr + 1) = AF_INET;
#else
    *(addr + 0) = AF_INET;              // sin_family low byte
#endif
    *(addr + 2) = PORT_HI;
    *(addr + 3) = PORT_LO;

    rc = bind(fd, addr, SOCKADDR_IN_SIZE);
    free(addr);
    if (rc < 0) { sock_close(fd); return -1; }

    rc = listen(fd, BACKLOG);
    if (rc < 0) { sock_close(fd); return -1; }

    sock_nonblock(fd);
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
    sock_close(slot_fd[i]);
    slot_fd[i] = -1;
    slot_state[i] = SLOT_FREE;
    slot_written[i] = 0;
}

int main() {
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

#ifdef _WIN32
    char *wsadata;
    // WSAStartup version 2.2; the WSADATA struct is ~408 bytes,
    // 512 leaves room without us caring about the exact layout.
    wsadata = malloc(512);
    if (WSAStartup(0x0202, wsadata) != 0) {
        printf("WSAStartup failed\n");
        return 1;
    }
    free(wsadata);
#endif

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

        rc = select(nfds + 1, rfds, wfds, 0, 0);
        if (rc < 0) break;

        if (fdset_isset(rfds, listener)) {
            client = accept(listener, 0, 0);
            if (client >= 0) {
                idx = find_free_slot();
                if (idx < 0) {
                    sock_close(client);            // no room -- drop
                } else {
                    sock_nonblock(client);
                    slot_fd[idx] = client;
                    slot_state[idx] = SLOT_READING;
                    slot_written[idx] = 0;
                }
            }
        }

        i = 0;
        while (i < MAX_CLIENTS) {
            if (slot_state[i] == SLOT_READING && fdset_isset(rfds, slot_fd[i])) {
                // Drain whatever the client sent (request line +
                // headers); we don't parse it. recv works on all
                // three platforms; read would be POSIX-only.
                n = recv(slot_fd[i], scratch, 1024, 0);
                if (n <= 0) {
                    close_slot(i);
                } else {
                    slot_state[i] = SLOT_WRITING;
                }
            } else if (slot_state[i] == SLOT_WRITING && fdset_isset(wfds, slot_fd[i])) {
                n = send(slot_fd[i],
                         response + slot_written[i],
                         response_len - slot_written[i],
                         0);
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

    sock_close(listener);
    free(slot_fd);
    free(slot_state);
    free(slot_written);
    free(rfds);
    free(wfds);
    free(scratch);
#ifdef _WIN32
    WSACleanup();
#endif
    return 0;
}
