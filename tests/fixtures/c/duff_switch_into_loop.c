// Duff's device: case labels inside the loop body of a switch are
// jump targets the dispatcher reaches, and the loop's back edge
// re-enters the body at its first case (C99 6.8.4.2). Also exercises
// K&R old-style parameters with storage-class specifiers and the
// C89 implicit-int local declaration.

send(to, from, count)
    register char *to, *from;
    register count;
{
    register n = (count + 7) / 8;
    switch (count % 8) {
    case 0: do { *to++ = *from++;
    case 7:      *to++ = *from++;
    case 6:      *to++ = *from++;
    case 5:      *to++ = *from++;
    case 4:      *to++ = *from++;
    case 3:      *to++ = *from++;
    case 2:      *to++ = *from++;
    case 1:      *to++ = *from++;
            } while (--n > 0);
    }
    return 0;
}

int main(void) {
    char a[39], b[39];
    int i;
    for (i = 0; i < 39; i++) { a[i] = (char) i; b[i] = 0; }
    send(b, a, 39);
    for (i = 0; i < 39; i++) {
        if (b[i] != a[i]) return 1;
    }
    return 0;
}
