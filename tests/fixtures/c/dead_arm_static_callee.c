// A static function called only from the arm of a comparison the
// front end folds (an object's address against null) is still emitted
// when that arm is: the liveness that drops unreferenced internal
// definitions and the code the emitter keeps must agree.

static int a;
static int calls;

static void g(void)
{
    calls += 1;
}

static void h(void)
{
    calls += 10;
}

void f(void)
{
    if (&a == 0) g();
}

void f2(void)
{
    if (&a != 0) h();
    else g();
}

int main(void)
{
    f();
    f2();
    return calls == 10 ? 0 : 1;
}
