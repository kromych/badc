// POSIX message queues (<mqueue.h>), present where <unistd.h> defines
// _POSIX_MESSAGE_PASSING other than -1: a queue opened with an attribute
// record reports it back, delivers the higher priority first, times a
// receive against an absolute deadline, and under O_NONBLOCK refuses to
// receive from an empty queue with EAGAIN. A kernel without message queues
// (ENOSYS) has nothing to check; macOS defines the option -1.
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#if defined(_POSIX_MESSAGE_PASSING) && _POSIX_MESSAGE_PASSING != -1
#include <mqueue.h>

static int round_trip(void) {
    char name[32], got[64];
    struct mq_attr attr, now;
    struct timespec deadline;
    unsigned int prio = 0;
    mqd_t q;

    if (sizeof(struct mq_attr) != 64 || sizeof(mqd_t) != 4) return 10;
    snprintf(name, sizeof name, "/badc-mq-%d", (int)getpid());
    memset(&attr, 0, sizeof attr);
    attr.mq_maxmsg = 4;
    attr.mq_msgsize = 64;
    q = mq_open(name, O_CREAT | O_EXCL | O_RDWR, 0600, &attr);
    if (q == (mqd_t)-1) return errno == ENOSYS ? 0 : 11;
    mq_unlink(name);
    if (mq_getattr(q, &now) != 0) return 12;
    if (now.mq_maxmsg != 4 || now.mq_msgsize != 64 || now.mq_curmsgs != 0) return 13;
    if (mq_send(q, "low", 4, 1) != 0 || mq_send(q, "high", 5, 7) != 0) return 14;
    if (mq_getattr(q, &now) != 0 || now.mq_curmsgs != 2) return 15;
    if (mq_receive(q, got, sizeof got, &prio) != 5 || prio != 7 || strcmp(got, "high") != 0)
        return 16;
    clock_gettime(CLOCK_REALTIME, &deadline);
    deadline.tv_sec += 5;
    if (mq_timedreceive(q, got, sizeof got, &prio, &deadline) != 4 || prio != 1 ||
        strcmp(got, "low") != 0)
        return 17;
    if (mq_timedsend(q, "timed", 6, 3, &deadline) != 0) return 18;
    if (mq_receive(q, got, sizeof got, 0) != 6) return 19;
    attr.mq_flags = O_NONBLOCK;
    if (mq_setattr(q, &attr, &now) != 0 || now.mq_flags != 0) return 20;
    if (mq_receive(q, got, sizeof got, 0) != -1 || errno != EAGAIN) return 21;
    if (mq_receive(q, got, 8, 0) != -1 || errno != EMSGSIZE) return 22;
    return mq_close(q) != 0 ? 23 : 0;
}
#endif

int main(void) {
#if defined(_POSIX_MESSAGE_PASSING) && _POSIX_MESSAGE_PASSING != -1
#ifdef __linux__
    if (_POSIX_MESSAGE_PASSING != 200809L) return 1;
#endif
    return round_trip();
#else
#ifdef __APPLE__
    return _POSIX_MESSAGE_PASSING == -1 ? 0 : 2;
#else
    return 3;
#endif
#endif
}
