int main() {
    int *p;
    p = malloc(8); // one int (8 bytes) of heap memory
    return p[100]; // way past the allocation
}
