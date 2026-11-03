// Library functions called with no header included take the declarations
// of the headers that declare them: strtod returns its double in the
// floating-point return register, and printf, variadic, returns the count
// of characters it wrote ("1.50\n").

int main(void)
{
    double d = strtod("1.5", 0);
    int n = printf("%.2f\n", d);
    return (d == 1.5 ? 0 : 1) | (n == 5 ? 0 : 2);
}
