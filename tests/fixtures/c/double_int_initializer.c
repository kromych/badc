/* C99 6.7.8p11 and 6.3.1.4: an integer constant that initializes a
   floating object is converted to the floating value; it is not stored
   as the integer's bit pattern. A double initialized with an integer
   constant must equal the converted value rather than landing in a
   denormal. */
double g_hundred = 100;
double g_neg = -5;
double g_sum = 2 + 3;

int main(void) {
    if (g_hundred != 100.0) {
        return 1;
    }
    if (g_neg != -5.0) {
        return 2;
    }
    if (g_sum != 5.0) {
        return 3;
    }
    return 0;
}
