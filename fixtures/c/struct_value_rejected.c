struct Foo { int x; };

int main() {
    // c4rs rejects struct-value declarations — pointers only.
    struct Foo bad;
    return 0;
}
