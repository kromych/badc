int main() {
    int *p;
    // Same idea as type_warning_int_to_ptr.c, but the cast tells the
    // compiler "I really do mean to put this integer in a pointer".
    p = (int *)5;
    return p == 0;
}
