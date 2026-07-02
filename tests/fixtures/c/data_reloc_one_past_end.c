/* A one-past-the-end address constant (C99 6.5.6p8) coincides with the
   following object's start; data compaction must keep it attributed to
   the preceding array when bss segregation moves the neighbor. */
long arr[4] = {1, 2, 3, 4};
long zeros[8];
long *const end_p = &arr[4];

int main(void) {
    long sum = 0;
    long *p = arr;
    while (p != end_p) {
        sum += *p;
        p++;
    }
    sum += zeros[3];
    return (int)sum;
}
