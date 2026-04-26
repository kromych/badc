int main() {
    char *s;
    // Three adjacent string literals must concatenate into one C string.
    s = "abc" "def" "ghi";
    // s[5] should be 'f' (a b c d e f g h i \0  →  index 5 = 'f' = 102)
    return s[5];
}
