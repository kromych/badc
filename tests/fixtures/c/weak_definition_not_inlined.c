// A weak definition is replaceable: the linker binds references to a
// strong definition of the same name in another object when one exists.
// The call therefore has to stay out of line under -O even though the
// body is small enough to inline.

__attribute__((weak)) int weak_answer(void) { return 1; }

__attribute__((weak)) int weak_scale(int x) { return x * 2; }

int main(void) { return weak_answer() + weak_scale(20) + 1; }
