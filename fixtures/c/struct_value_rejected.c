struct Foo { int x; };

int main() {
    // badc rejects struct-value declarations -- pointers only.
    struct Foo bad;
    return 0;
}
