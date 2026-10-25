// mqueue.h -- POSIX message queues (Linux), bound to glibc's calls in
// libc.so.6. The macOS SDK has no message queues and no <mqueue.h>.

#pragma once

#ifdef __linux__
#include <fcntl.h>
#include <signal.h>
#include <sys/types.h>
#include <time.h>

typedef int mqd_t;

// glibc's 64-byte attribute record.
struct mq_attr {
    long mq_flags;
    long mq_maxmsg;
    long mq_msgsize;
    long mq_curmsgs;
    long __pad[4];
};

#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::mq_open, "mq_open")
#pragma binding(libc::mq_close, "mq_close")
#pragma binding(libc::mq_getattr, "mq_getattr")
#pragma binding(libc::mq_setattr, "mq_setattr")
#pragma binding(libc::mq_unlink, "mq_unlink")
#pragma binding(libc::mq_notify, "mq_notify")
#pragma binding(libc::mq_receive, "mq_receive")
#pragma binding(libc::mq_send, "mq_send")
#pragma binding(libc::mq_timedreceive, "mq_timedreceive")
#pragma binding(libc::mq_timedsend, "mq_timedsend")

mqd_t mq_open(const char *name, int oflag, ...);
int mq_close(mqd_t mqdes);
int mq_getattr(mqd_t mqdes, struct mq_attr *mqstat);
int mq_setattr(mqd_t mqdes, const struct mq_attr *restrict mqstat,
               struct mq_attr *restrict omqstat);
int mq_unlink(const char *name);
int mq_notify(mqd_t mqdes, const struct sigevent *notification);
ssize_t mq_receive(mqd_t mqdes, char *msg_ptr, size_t msg_len, unsigned int *msg_prio);
int mq_send(mqd_t mqdes, const char *msg_ptr, size_t msg_len, unsigned int msg_prio);
ssize_t mq_timedreceive(mqd_t mqdes, char *restrict msg_ptr, size_t msg_len,
                        unsigned int *restrict msg_prio,
                        const struct timespec *restrict abs_timeout);
int mq_timedsend(mqd_t mqdes, const char *msg_ptr, size_t msg_len, unsigned int msg_prio,
                 const struct timespec *abs_timeout);
#endif
