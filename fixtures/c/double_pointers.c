int main() {
    int a;
    int *p;
    int **pp;
    int **matrix;

    // 1. Basic address-of and double dereference
    a = 10;
    p = &a;
    pp = &p;

    **pp = 42; // Modifies 'a' through the double pointer

    if (a != 42) return 1;
    if (*p != 42) return 2;

    // 2. Dynamic memory and 2D array syntax
    matrix = malloc(8);    // Allocate array of 1 pointer (8 bytes)
    matrix[0] = malloc(8); // Allocate array of 1 integer for the first row

    matrix[0][0] = 123;    // Write via chained brackets

    if (**matrix != 123) return 3;
    if (matrix[0][0] != 123) return 4;

    return 0; // Success
}
