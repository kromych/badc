// __builtin_return_address(0): the current function's return address
// (level 0). Native reads the saved return slot above the frame pointer;
// the interpreter returns a stable non-zero per-frame proxy. Either way
// it must be non-null when called from a real call site.
void *captured;
static void capture(void) { captured = __builtin_return_address(0); }
int main(void) {
    capture();
    return captured != 0 ? 0 : 1;
}
