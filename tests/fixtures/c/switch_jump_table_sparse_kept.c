// A sparse case set keeps the balanced compare tree: with more than
// half the span made of holes a table would waste text, so the
// lowering's density gate (span < 2 * cases) must reject it. The
// routing semantics are identical either way; the asm snapshots lock
// the absence of the indexed-branch shape.

static int sparse(int x) {
    switch (x) {
        case 0:   return 1;
        case 10:  return 2;
        case 20:  return 3;
        case 30:  return 4;
        case 40:  return 5;
        case 50:  return 6;
        case 60:  return 7;
        case 70:  return 8;
        case 80:  return 9;
        case 90:  return 10;
        default:  return -1;
    }
}

int main(void) {
    for (int i = 0; i < 10; i++) {
        if (sparse(i * 10) != i + 1) return 1;
    }
    if (sparse(5) != -1) return 2;
    if (sparse(-10) != -1) return 3;
    if (sparse(100) != -1) return 4;
    return 0;
}
