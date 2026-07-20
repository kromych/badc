/* GNU `hot` / `cold` are optimization hints; they parse in every
   declarator position and change no behavior. */
__attribute__((hot)) int fast_path(int x) { return x + 1; }
__attribute__((cold)) static int slow_path(int x) { return x - 1; }
__attribute__((cold, noinline)) int error_path(void) { return 41; }
int hot_decl(int) __attribute__((hot));
int hot_decl(int x) { return x * 2; }

int main(void) {
    if (fast_path(1) != 2) {
        return 1;
    }
    if (slow_path(1) != 0) {
        return 2;
    }
    if (error_path() != 41) {
        return 3;
    }
    if (hot_decl(21) != 42) {
        return 4;
    }
    return 0;
}
